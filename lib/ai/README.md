# 🤖 FitMind+ AI Backend Mimarisi

Bu dizin, FitMind+ uygulamasının AI chat backend'lerini yöneten temiz mimariyi içerir.

## 📁 Dosya Yapısı

```
lib/ai/
├── chat_backend.dart    # Ana backend mimarisi
│   ├── ChatBackend      # Abstract interface
│   ├── OllamaBackend    # Ollama implementasyonu
│   ├── OpenAiBackend    # OpenAI implementasyonu
│   └── ChatBackendFactory # Backend factory
└── README.md            # Bu dosya
```

---

## 🏗️ Mimari Tasarım

### Abstract Interface: `ChatBackend`

```dart
abstract class ChatBackend {
  String get name;                           // Backend adı: "Ollama" / "OpenAI"
  Future<String> sendMessage(String message); // Mesaj gönder, yanıt al
  Future<bool> isAvailable();                 // Backend erişilebilir mi?
}
```

**Avantajlar:**
- ✅ **Dependency Inversion**: UI backend'den bağımsız
- ✅ **Open/Closed**: Yeni backend eklemek kolay (Anthropic, Gemini, vb.)
- ✅ **Testability**: Mock backend ile UI test mümkün
- ✅ **Liskov Substitution**: Her backend aynı contract'a uyar

---

## 🔧 Backend Implementasyonları

### 1️⃣ OllamaBackend (Yerel AI)

**Özellikler:**
- 🏠 Localhost üzerinde çalışır (http://localhost:11434)
- 🚀 Model: `qwen2.5:1.5b` (değiştirilebilir)
- ⏱️ Timeout: 40 saniye
- 📦 Endpoint: `/api/generate`

**Constructor:**
```dart
OllamaBackend({
  String baseUrl = 'http://localhost:11434',
  String model = 'qwen2.5:1.5b',
  Duration timeout = const Duration(seconds: 40),
})
```

**Request Format:**
```json
{
  "model": "qwen2.5:1.5b",
  "prompt": "SYSTEM_PROMPT\n\nKULLANICI MESAJI:\n{message}\n\nCEVAP:",
  "stream": false,
  "options": {
    "num_predict": 256,
    "temperature": 0.7,
    "top_p": 0.9,
    "top_k": 40
  }
}
```

**Hata Yönetimi:**
- ⏰ **Timeout**: 40 saniye aşılırsa → "Model çok büyük veya sistem yavaş"
- 🔌 **SocketException**: Bağlantı yok → "ollama serve çalıştığından emin ol"
- 🔴 **HTTP 404**: Model yok → "ollama list ile kontrol et"
- 🔴 **HTTP 500**: Sunucu hatası
- 📄 **JSON Parse Error**: Yanıt bozuk

**Kullanım:**
```dart
// Factory ile
final backend = ChatBackendFactory.createOllama();

// Direkt
final backend = OllamaBackend(
  model: 'llama3.2:3b',  // Farklı model
  timeout: Duration(seconds: 60),
);

final response = await backend.sendMessage('Protein miktarı ne olmalı?');
print(response); // "Vücut ağırlığının kg başına 1.6-2.2g..."
```

---

### 2️⃣ OpenAiBackend (Cloud AI)

**Özellikler:**
- ☁️ OpenAI Cloud API
- 🤖 Model: `gpt-4o-mini` (varsayılan)
- ⏱️ Timeout: 30 saniye
- 📦 Endpoint: `/v1/chat/completions`

**Constructor:**
```dart
OpenAiBackend({
  required String apiKey,            // ZORUNLU: OpenAI API key
  String model = 'gpt-4o-mini',      // Model seçimi
  String baseUrl = 'https://api.openai.com/v1',
  Duration timeout = const Duration(seconds: 30),
})
```

**Request Format:**
```json
{
  "model": "gpt-4o-mini",
  "messages": [
    {
      "role": "system",
      "content": "Sen FitMind+ için Türkçe konuşan fitness koçusun..."
    },
    {
      "role": "user",
      "content": "{message}"
    }
  ],
  "max_tokens": 300,
  "temperature": 0.7,
  "top_p": 0.9
}
```

**Hata Yönetimi:**
- 🔑 **API Key Boş**: Hemen exception → "API key tanımlanmamış"
- ⏰ **Timeout**: 30 saniye aşılırsa
- 🔌 **SocketException**: İnternet yok → "İnternet bağlantını kontrol et"
- 🔴 **HTTP 401**: Geçersiz key → "API key geçersiz. Ayarlardan kontrol et."
- 🔴 **HTTP 429**: Rate limit → "Biraz bekle."
- 🔴 **HTTP 500/503**: Sunucu hatası
- 📄 **OpenAI Error Response**: `error.message` field'ını parse eder

**Kullanım:**
```dart
// Factory ile
final backend = ChatBackendFactory.createOpenAi(
  apiKey: 'sk-proj-abc123...',
);

// Direkt (custom model)
final backend = OpenAiBackend(
  apiKey: 'sk-proj-abc123...',
  model: 'gpt-4',  // Daha güçlü model
  timeout: Duration(seconds: 45),
);

final response = await backend.sendMessage('Kardiyo kaç gün yapmalıyım?');
print(response); // "Haftada 3-4 gün..."
```

---

## 🏭 Factory Pattern Kullanımı

### ChatBackendFactory

**Ollama:**
```dart
// Varsayılan ayarlar
final ollama = ChatBackendFactory.createOllama();

// Custom ayarlar
final ollama = ChatBackendFactory.createOllama(
  model: 'llama3.2:3b',
  baseUrl: 'http://192.168.1.100:11434',  // Farklı sunucu
  timeout: Duration(seconds: 60),
);
```

**OpenAI:**
```dart
// Varsayılan (gpt-4o-mini)
final openai = ChatBackendFactory.createOpenAi(
  apiKey: 'sk-proj-...',
);

// Custom model
final openai = ChatBackendFactory.createOpenAi(
  apiKey: 'sk-proj-...',
  model: 'gpt-4-turbo',
);
```

---

## 💡 UI Entegrasyonu

### Kullanım: `AiChatPage`

**Dosya:** `lib/pages/ai_chat_page.dart`

```dart
// Dosya başı (satır 7-8)
const bool _useOpenAi = false;           // Backend seçimi
const String _openAiApiKey = '';         // OpenAI key (gerekirse)

// State class içinde
class _AiChatPageState extends State<AiChatPage> {
  late final ChatBackend _backend;
  
  ChatBackend _initializeBackend() {
    if (_useOpenAi) {
      if (_openAiApiKey.isEmpty) {
        // Fallback to Ollama
        return ChatBackendFactory.createOllama();
      }
      return ChatBackendFactory.createOpenAi(apiKey: _openAiApiKey);
    } else {
      return ChatBackendFactory.createOllama();
    }
  }
  
  @override
  void initState() {
    super.initState();
    _backend = _initializeBackend();
  }
  
  Future<void> _sendMessage() async {
    // ...
    try {
      final response = await _backend.sendMessage(text);
      // Mesajı ekle
    } on AiBackendException catch (e) {
      // Hata göster
      setState(() => _errorMessage = e.message);
    }
  }
}
```

**Backend Seçimi:**
```dart
// Ollama kullan (varsayılan)
const bool _useOpenAi = false;

// OpenAI'ye geç
const bool _useOpenAi = true;
const String _openAiApiKey = 'sk-proj-abc123...';
```

**Hot Reload:** Backend değişikliği için `r` tuşuna bas.

**AppBar Badge:** Aktif backend adı sağ üstte görünür ("Ollama" / "OpenAI")

---

## 🔐 API Key Yönetimi

### Şu Anki Yöntem (Geliştirme)

```dart
// lib/pages/ai_chat_page.dart
const String _openAiApiKey = 'sk-proj-...';  // Hard-coded
```

⚠️ **UYARI**: Gerçek projede API key'leri kaynak koduna koymayın!

### Önerilen Yöntemler

**1. SharedPreferences (Basit):**
```dart
// Ayarlar ekranında kaydet
final prefs = await SharedPreferences.getInstance();
await prefs.setString('openai_api_key', key);

// AI Chat'te oku
final apiKey = prefs.getString('openai_api_key') ?? '';
final backend = ChatBackendFactory.createOpenAi(apiKey: apiKey);
```

**2. flutter_secure_storage (Güvenli):**
```dart
// Kaydet
final storage = FlutterSecureStorage();
await storage.write(key: 'openai_key', value: apiKey);

// Oku
final apiKey = await storage.read(key: 'openai_key') ?? '';
```

**3. Env Dosyası (Production):**
```dart
// .env
OPENAI_API_KEY=sk-proj-...

// Dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
```

**4. Backend Service (En Güvenli):**
- API key'i backend sunucunuzda tutun
- App → Your Backend → OpenAI
- Key asla client'a gelmez

---

## 🧪 Test ve Debug

### isAvailable() Kontrolü

```dart
final ollama = ChatBackendFactory.createOllama();
final available = await ollama.isAvailable();

if (!available) {
  print('⚠️  Ollama çalışmıyor! "ollama serve" komutunu çalıştır');
}
```

### Debug Logları

Backend'ler her adımda `debugPrint` kullanır:

**Başarılı İstek:**
```
🔵 [Ollama] İstek gönderiliyor
   📍 URL: http://localhost:11434/api/generate
   🤖 Model: qwen2.5:1.5b
   ⏱️  Timeout: 40s
🟢 [Ollama] HTTP yanıtı alındı: 200
🟢 [Ollama] JSON parse başarılı
✅ [Ollama] Başarılı: 87 karakter
```

**Hata:**
```
🔵 [OpenAI] İstek gönderiliyor
   🤖 Model: gpt-4o-mini
   ⏱️  Timeout: 30s
🟢 [OpenAI] HTTP yanıtı alındı: 401
🔴 [OpenAI] HTTP HATA: 401
AiBackendException [OpenAI]: API key geçersiz. Lütfen ayarlardan kontrol et.
```

---

## 📊 Backend Karşılaştırması

| Özellik | Ollama | OpenAI |
|---------|--------|--------|
| **Konum** | Localhost | Cloud |
| **Maliyet** | Ücretsiz | Ücretli ($) |
| **Hız** | GPU'ya bağlı | Sabit (hızlı) |
| **İnternet** | Gereksiz | Gerekli |
| **Model** | qwen2.5:1.5b (küçük) | gpt-4o-mini (güçlü) |
| **Timeout** | 40s | 30s |
| **Privacy** | %100 yerel | Cloud'a gider |
| **Setup** | Ollama kurulumu | API key |

**Öneri:**
- 🏠 **Geliştirme**: Ollama (ücretsiz, hızlı test)
- ☁️ **Production**: OpenAI (tutarlı kalite, düşük gecikme)
- 🔄 **Hybrid**: Ayarlarda ikisini de seçenek sun

---

## 🚀 Sonraki Adımlar

### 1. Ayarlar Ekranı
```dart
// lib/screens/settings_screen.dart

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Backend seçimi
        SwitchListTile(
          title: Text('OpenAI Kullan'),
          value: _useOpenAi,
          onChanged: (value) async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('use_openai', value);
          },
        ),
        
        // API Key input (OpenAI seçiliyse)
        if (_useOpenAi)
          TextField(
            decoration: InputDecoration(labelText: 'OpenAI API Key'),
            obscureText: true,
            onChanged: (key) async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('openai_key', key);
            },
          ),
      ],
    );
  }
}
```

### 2. Model Seçimi
```dart
DropdownButton<String>(
  value: _selectedModel,
  items: [
    DropdownMenuItem(value: 'qwen2.5:1.5b', child: Text('Qwen 1.5B')),
    DropdownMenuItem(value: 'llama3.2:3b', child: Text('Llama 3.2 3B')),
    DropdownMenuItem(value: 'gpt-4o-mini', child: Text('GPT-4o Mini')),
    DropdownMenuItem(value: 'gpt-4', child: Text('GPT-4')),
  ],
  onChanged: (model) {
    // Ayarı kaydet
  },
);
```

### 3. Streaming Desteği (İleri Seviye)
```dart
abstract class ChatBackend {
  Stream<String> sendMessageStream(String message);
}

// Ollama streaming
final stream = backend.sendMessageStream('Merhaba');
await for (final chunk in stream) {
  print(chunk); // Kelime kelime gelir
}
```

### 4. Yeni Backend Ekleme (Örn: Anthropic Claude)
```dart
class AnthropicBackend implements ChatBackend {
  final String apiKey;
  
  AnthropicBackend({required this.apiKey});
  
  @override
  String get name => 'Claude';
  
  @override
  Future<String> sendMessage(String message) async {
    final uri = Uri.parse('https://api.anthropic.com/v1/messages');
    // Claude API entegrasyonu
  }
}

// Factory'ye ekle
static ChatBackend createAnthropic({required String apiKey}) {
  return AnthropicBackend(apiKey: apiKey);
}
```

---

## 📚 Referanslar

- **Ollama Docs**: https://github.com/ollama/ollama/blob/main/docs/api.md
- **OpenAI API**: https://platform.openai.com/docs/api-reference/chat
- **Flutter http**: https://pub.dev/packages/http
- **SOLID Principles**: https://en.wikipedia.org/wiki/SOLID

---

## 🐛 Sorun Giderme

### "Ollama sunucusuna bağlanılamadı"
```bash
# Terminal'de çalıştır
ollama serve

# Farklı port kullanıyorsan
ollama serve --port 11435

# Backend'de güncelle
ChatBackendFactory.createOllama(baseUrl: 'http://localhost:11435')
```

### "OpenAI API key geçersiz"
1. https://platform.openai.com/api-keys adresinden yeni key oluştur
2. `sk-proj-` ile başladığından emin ol
3. Doğru kopyaladığını kontrol et (boşluk yok)

### "Timeout hatası"
```dart
// Timeout süresini artır
ChatBackendFactory.createOllama(
  timeout: Duration(seconds: 120),  // 2 dakika
);
```

### "Model bulunamadı"
```bash
# Yüklü modelleri listele
ollama list

# Model indir
ollama pull qwen2.5:1.5b
```

---

**Yazarlar**: FitMind+ AI Team  
**Versiyon**: 1.0.0  
**Son Güncelleme**: 18 Kasım 2025
