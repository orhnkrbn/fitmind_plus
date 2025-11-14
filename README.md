<!-- PROJECT LOGO -->
<p align="center">
  <img src="https://raw.githubusercontent.com/orhnkrbn/fitmind_plus/main/assets/icon/icon.png" alt="Logo" width="120">
</p>

<h1 align="center">FitMind+ 🧠💪<br>AI Powered Fitness & Motivation Coach</h1>

<p align="center">
  Your personal smart fitness companion — powered by Flutter + AI.<br>
  <a href="#"><strong>Explore the docs »</strong></a><br><br>
  🚧 Under Development • Android First
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue" />
  <img src="https://img.shields.io/badge/Platform-Android-green" />
  <img src="https://img.shields.io/badge/AI-Ollama%20%7C%20OpenAI-orange" />
  <img src="https://img.shields.io/badge/Status-Active-brightgreen" />
  <img src="https://img.shields.io/badge/License-MIT-lightgrey" />
</p>

---

# 📌 Overview

**FitMind+**, fiziksel gelişim ve mental motivasyonu birleştiren yapay zekâ destekli bir kişisel koç uygulamasıdır.  
Kullanıcıya:

- Bilimsel antrenman rehberi  
- Doğru beslenme içerikleri  
- Günlük motivasyon desteği  
- AI tabanlı kişiselleştirilmiş yönlendirmeler  

sunmak üzere geliştirilmiştir.

Uygulama modern, akıcı, Apple Fitness benzeri bir UI/UX ile tasarlanmıştır ve tamamen Flutter ile geliştirilir.

---

# ✨ Features

## 🧠 AI Content Engine
- Local AI (Ollama – Qwen/Phi modelleri)
- Cloud AI (OpenAI / Anthropic / DeepSeek)
- Akıllı içerik üretimi
- FitMind yönlendirme sistemi

## 💪 Training Zone
- Bilimsel antrenman içerikleri
- Kas grubu bazlı eğitim
- JSON tabanlı dinamik içerik sistemi

## 🥗 Nutrition Notes
- Basit & doğru beslenme prensipleri
- Temel makro/mikro besinler
- AI’ya göre kişisel öneriler

## ⚡ Modern UI / Smooth Animations
- Apple Fitness tarzı minimal tasarım
- Altın oran uyumlu layout
- High-performance widget yapısı

## 🎯 Motivation Hub
- Günlük motivasyon kartları
- AI’dan kişisel yönlendirmeler
- Odak & disiplin modları

---

# 🛠️ Tech Stack
- **Flutter (Dart)**
- **Riverpod / Provider**
- **Dio**
- **Ollama Local AI**
- **OpenAI REST API**
- **MVVM + Repository Pattern**
- **JSON-based Content Engine**

---

# 🧩 Architecture

#### 📁 Project File Structure

```plaintext
lib/
 ├── core/
 │    ├── constants/
 │    ├── services/
 │    │     ├── ai/
 │    │     │     ├── ai_client_interface.dart
 │    │     │     ├── openai_service.dart
 │    │     │     └── ollama_service.dart
 │    └── utils/
 ├── data/
 │    ├── models/
 │    ├── repositories/
 ├── providers/
 ├── ui/
 │    ├── screens/
 │    ├── widgets/
 │    └── themes/
 └── assets/
      └── json/
```
---

# 🧪 Development

## ▶️ Run
```bash
flutter pub get
flutter run
```

## ▶️ Build
```bash
flutter build apk
flutter build appbundle
```

---

# 🔐 Environment Variables

Proje kök dizinine bir `.env` dosyası ekleyin:

```env
OPENAI_API_KEY=your_key_here
```

> `.env` **asla repoya eklenmez.**  
> `.env.example` sadece örnek olarak commit edilebilir.

---

# 🤖 AI Integration Roadmap

## ✔️ Stage 1 — Local AI Mode
- Ollama backend  
- Qwen 4B / Phi modelleri  
- Offline AI çalışma modu  

## ✔️ Stage 2 — Cloud AI Mode
- OpenAI GPT  
- Anthropic Claude  
- DeepSeek  
- Hybrid fast/accurate routing  

## ✔️ Stage 3 — Smart Fitness Modules
- Smart Calorie Scanner  
- Workout Generator  
- Adaptive Motivation Engine  
- Personalized analytics  

---

# 📅 Product Roadmap

### 🔹 v0.1.0 – MVP UI
- Navigation  
- JSON content system  
- Base screens  

### 🔹 v0.2.0 – Local AI Integration
- Ollama AI service  
- AI chatbot  
- Model switcher  

### 🔹 v0.3.0 – Premium UI Refresh
- Modern animasyonlar  
- Altın oran tasarım  

### 🔹 v0.4.0 – Cloud AI Hybrid Mode
- OpenAI / Anthropic  
- Smart suggestions engine  

### 🔹 v1.0.0 – Public Release
- Performans iyileştirmeleri  
- Play Store yayını  

---

# 👤 Developer

**Orhan Kurban**  
Creator & Lead Developer of FitMind+

---

# 📄 License

MIT License.