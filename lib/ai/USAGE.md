# 🔧 AI Backend Kullanım Örnekleri

## 🎯 Backend Seçimi (Type-Safe)

### Yöntem 1: Enum ile (Önerilen)

```dart
// Ollama backend
const aiChatPage = AiChatPage(
  backendType: ChatBackendType.ollama,
);

// OpenAI backend
const aiChatPage = AiChatPage(
  backendType: ChatBackendType.openai,
  openAiApiKey: 'sk-proj-abc123...',
);
```

### Yöntem 2: Varsayılan (Olmadan)

```dart
// _defaultBackendType (ChatBackendType.ollama) kullanılır
const aiChatPage = AiChatPage();
```

---

## 🏭 Factory ile Backend Oluşturma

### Enum-Based (Yeni)

```dart
// Ollama
final backend = ChatBackendFactory.create(
  type: ChatBackendType.ollama,
);

// OpenAI
final backend = ChatBackendFactory.create(
  type: ChatBackendType.openai,
  apiKey: 'sk-proj-...',
);

// Custom ayarlar
final backend = ChatBackendFactory.create(
  type: ChatBackendType.ollama,
  model: 'llama3.2:3b',
  timeout: Duration(seconds: 60),
);
```

### Direkt Metod (Eski Yöntem)

```dart
// Hala çalışır
final ollama = ChatBackendFactory.createOllama();
final openai = ChatBackendFactory.createOpenAi(apiKey: '...');
```

---

## 🎨 UI: AppBar Backend Badge

**Görünüm:**
```
┌─────────────────────────────────────┐
│ 🤖  FitMind+ AI Koç                 │
│     Spor, beslenme için yanında     │
│     [AI Motoru: Ollama]  ← Badge    │
└─────────────────────────────────────┘
```

**Özellikleri:**
- Otomatik güncellenir (`_backend.name`)
- "AI Motoru: Ollama" veya "AI Motoru: OpenAI"
- Beyaz saydam arka plan
- Gradient AppBar'da sağ üstte

---

## 🔄 Ayarlar Ekranı Entegrasyonu (Gelecek)

```dart
// lib/screens/settings_screen.dart

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ChatBackendType _selectedBackend = ChatBackendType.ollama;
  String _openAiKey = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Backend seçimi
        DropdownButton<ChatBackendType>(
          value: _selectedBackend,
          items: const [
            DropdownMenuItem(
              value: ChatBackendType.ollama,
              child: Text('Ollama (Yerel)'),
            ),
            DropdownMenuItem(
              value: ChatBackendType.openai,
              child: Text('OpenAI (Cloud)'),
            ),
          ],
          onChanged: (type) async {
            setState(() => _selectedBackend = type!);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('backend_type', type!.name);
          },
        ),
        
        // API Key input (OpenAI seçiliyse)
        if (_selectedBackend == ChatBackendType.openai)
          TextField(
            decoration: const InputDecoration(
              labelText: 'OpenAI API Key',
              hintText: 'sk-proj-...',
            ),
            obscureText: true,
            onChanged: (key) async {
              _openAiKey = key;
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('openai_key', key);
            },
          ),
      ],
    );
  }
}
```

### Ayarları Yükleme

```dart
// lib/pages/ai_chat_page.dart için helper
Future<ChatBackendType> _loadBackendType() async {
  final prefs = await SharedPreferences.getInstance();
  final typeName = prefs.getString('backend_type') ?? 'ollama';
  return ChatBackendType.values.firstWhere(
    (e) => e.name == typeName,
    orElse: () => ChatBackendType.ollama,
  );
}

Future<String?> _loadOpenAiKey() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('openai_key');
}

// Kullanım
@override
void initState() {
  super.initState();
  _loadSettings();
}

Future<void> _loadSettings() async {
  final type = await _loadBackendType();
  final key = await _loadOpenAiKey();
  
  setState(() {
    // Widget'ı yeniden oluştur
  });
}
```

---

## 🧪 Test Senaryoları

### 1. Ollama Backend

```dart
// Route tanımı
MaterialPageRoute(
  builder: (context) => const AiChatPage(
    backendType: ChatBackendType.ollama,
  ),
);
```

**Beklenen:**
- AppBar badge: "AI Motoru: Ollama"
- Console: `✅ Ollama backend aktif`
- HTTP: `http://localhost:11434/api/generate`

### 2. OpenAI Backend

```dart
MaterialPageRoute(
  builder: (context) => const AiChatPage(
    backendType: ChatBackendType.openai,
    openAiApiKey: 'sk-proj-abc123...',
  ),
);
```

**Beklenen:**
- AppBar badge: "AI Motoru: OpenAI"
- Console: `✅ OpenAI backend aktif`
- HTTP: `https://api.openai.com/v1/chat/completions`

### 3. Fallback Test (Key Yok)

```dart
MaterialPageRoute(
  builder: (context) => const AiChatPage(
    backendType: ChatBackendType.openai,
    // openAiApiKey yok!
  ),
);
```

**Beklenen:**
- Console: `⚠️ OpenAI API key boş, Ollama kullanılıyor`
- AppBar badge: "AI Motoru: Ollama"
- Otomatik fallback çalışır

---

## 📊 Enum Avantajları

### ❌ Eski Yöntem (bool flag)
```dart
const bool _useOpenAi = false;  // Tip güvenliği yok
if (_useOpenAi) { ... }         // Yanlışlıkla başka bool kullanılabilir
```

### ✅ Yeni Yöntem (enum)
```dart
const ChatBackendType _backendType = ChatBackendType.ollama;  // Tip güvenli
switch (_backendType) {  // Derleyici tüm case'leri kontrol eder
  case ChatBackendType.ollama:
  case ChatBackendType.openai:
}
```

**Faydalar:**
- 🔒 **Type Safety**: Yanlış değer atanamaz
- 🔍 **IDE Support**: Auto-complete çalışır
- ⚠️ **Compile-time Check**: Eksik case varsa hata verir
- 📝 **Readability**: `ChatBackendType.ollama` > `false`
- 🔄 **Extensibility**: Yeni backend eklemek kolay

---

## 🚀 Gelecek Backend Ekleme

```dart
// 1. Enum'a ekle
enum ChatBackendType {
  ollama,
  openai,
  anthropic,  // ← Yeni
}

// 2. Implementation oluştur
class AnthropicBackend implements ChatBackend {
  @override
  String get name => 'Claude';
  
  // ... implementation
}

// 3. Factory'ye ekle
static ChatBackend create({...}) {
  switch (type) {
    case ChatBackendType.ollama: ...
    case ChatBackendType.openai: ...
    case ChatBackendType.anthropic:  // ← Yeni case
      return AnthropicBackend(apiKey: apiKey!);
  }
}

// 4. UI'da kullan
const AiChatPage(
  backendType: ChatBackendType.anthropic,
  openAiApiKey: 'sk-ant-...',  // Anahtar ismi genel
);
```

---

## 📝 Best Practices

### ✅ Yapılması Gerekenler

1. **Enum kullan** (bool yerine)
2. **Factory pattern** kullan (direkt constructor yerine)
3. **API key'i widget parametresi** yap (hard-coded değil)
4. **Fallback logic** ekle (key yoksa Ollama)
5. **Badge göster** (kullanıcı hangi backend'i kullandığını bilsin)

### ❌ Yapılmaması Gerekenler

1. ~~`if (_useOpenAi)`~~ → `switch (backendType)`
2. ~~`const String _openAiApiKey = 'sk-...'`~~ → Constructor param
3. ~~Widget içinde `new OllamaBackend()`~~ → Factory kullan
4. ~~Backend değişince restart gereksin~~ → Ayarlardan değiştirilebilir
5. ~~Backend adı hardcoded~~ → `_backend.name` kullan

---

**Son Güncelleme:** 18 Kasım 2025  
**Versiyon:** 2.0.0 (Enum support)
