## FitMind+ — Copilot Talimatları

Aşağıdaki kısa talimatlar, bu Flutter tabanlı proje üzerinde bir AI kod asistanının hızlıca üretken olmasını sağlar. Odak: proje yapısı, kritik dosyalar, çalışma akışları ve yerel konvansiyonlar.

- Proje türü: Flutter uygulaması (mobil + web/PWA) — ana kaynaklar `lib/`, platform dizinleri `android/`, `ios/`, `web/`.
- Ana giriş: `lib/main.dart`.

Önemli dizinler ve roller (örnek dosyalar):
- `lib/app/router.dart` — Uygulama rotaları ve navigation merkezidir; yeni ekran eklerken burayı güncelle.
- `lib/providers/` — State/provide yapıları (örn. `auth_provider.dart`, `workout_provider.dart`). Yeni global state eklerken Provider/ChangeNotifier modelini takip et.
- `lib/core/` — platform bağımsız çekirdek kodlar: `firebase/`, `localization/`, `features/`, `settings/`.
- `lib/services/` — dış sistemlerle iletişim (API, local storage, vb.).
- `lib/models/` — veri modelleri (`app_user.dart`, `workout.dart`) — JSON (de)serileştirme düzeni burada korunur.
- `assets/ml/food.tflite` — on-device ML modeli; ML güdümlü değişiklikler yaparken bu yolu koru.
- `lib/firebase_options.dart` ve `android/app/google-services.json` — Firebase konfigürasyonu; Firebase değişikliklerinde bu dosyalar güncellenir.

Proje özel konvansiyonları ve diğer dikkat edilmesi gerekenler:
- State: Provider/ChangeNotifier tercih ediliyor. Yeni feature'larda mevcut provider'ları genişlet veya yeni provider ekle.
- Ekranlar `lib/screens/` altında; `home`, `login`, `signup`, `splash` gibi isimlendirme tutarlılığı var — yeni ekranlarda aynı sırayı takip et.
- Router güncellemesi: yeni ekran ekleyince `router.dart` içine route tanımı ve ilgili import'u ekle.
- Asset erişimi: `assets/` içinde resimler, sesler, ml dosyaları bulunur; `pubspec.yaml`'de tanımlı olduğundan emin ol.

Çalışma ve derleme: (Windows PowerShell bağlamında)
- Bağımlılıkları almak: `flutter pub get`
- Geliştirme cihazında çalıştırma: `flutter run -d <deviceId>` veya Android için `flutter run`.
- APK oluşturma: `flutter build apk` (CI/Release için `flutter build appbundle` tercih edilebilir).
- Web (PWA) test: `flutter build web` ve `web/` içeriğini host et.
- Native Android/iOS: `android/gradlew` ve Xcode projeleri mevcut; native yapı değişikliklerinde platform dizinlerini kullan.

Testler ve kalite kontrol
- Testler: `test/widget_test.dart` mevcut; repo geniş kapsamlı test içermiyor — küçük değişiklikler için mevcut testi güncelle veya yeni test ekle.
- Lint/format: Flutter analiz ve format kuralları kullanılıyor; PR öncesi `flutter analyze` ve `flutter format .` çalıştır.

İntegrasyonlar ve dış bağımlılıklar
- Firebase: `lib/firebase_options.dart` ile projeye entegre. Android `google-services.json`, iOS tarafı `GoogleService-Info.plist` benzeri config beklenir.
- On-device ML: `assets/ml/food.tflite` — model kullanım kodları `lib/` altında olabilir; modeli güncellerken boyut ve API uyumluluğunu kontrol et.

Kodu değiştirirken dikkat
- README.md dosyasında birleştirme çatışması işaretleri (`<<<<<<<`) var — otomatik değişikliklerde bu dosyaya dokunma veya dikkatlice çöz.
- Büyük refactor'larda önce küçük bir test PR'ı (ör. tek bir ekran/servis) oluştur: provider & router değişiklikleri en çok etkileyen yerlerdir.

Hızlı örnekler (nereleri düzenle):
- Yeni ekran ekleme: `lib/screens/my_new_screen.dart` oluştur, `lib/app/router.dart` içine import ve route ekle, gerekli provider varsa `lib/providers/` içine ekle.
- Yeni servis ekleme: `lib/services/my_api_service.dart` oluştur, kullanıldığı yerde `Provider` ile expose et ve `lib/core/` altındaki ilgili kullanılarda çağır.

Küçük "kontrat" (AI asistanı için)
- Girdi: kod dosyaları ve küçük değişiklik talepleri (örn. yeni route, provider, küçük bug fix).
- Çıktı: minimal, test edilmiş değişiklikler; `pubspec.yaml` veya platform config'lerinde değişiklik gerekiyorsa bunu açıkça belirt ve PR notu hazırla.
- Hata modları: build hatası (platform-specific) veya Firebase config eksikliği; bu durumlarda kullanıcıya hangi gizli/yerel dosyaların gerektiğini (ör. `google-services.json`) bildir.

Referans dosyalar (başlangıç için bakılacaklar):
- `lib/main.dart`, `lib/app/router.dart`, `lib/providers/`, `lib/services/`, `lib/core/`, `pubspec.yaml`, `assets/ml/food.tflite`, `lib/firebase_options.dart`.

Eğer eksik veya net olmayan yerler varsa, bana hangi feature/eklentide çalışacağımı söyleyin; gerektiğinde platform (Android/iOS/web) belirtin.

---
Lütfen bu taslağı gözden geçirip, eksik gördüğünüz proje-özgü detayları (örn. özel lint kuralları, CI komutları, gizli konfigürasyon yolları) paylaşın; hemen güncelleyeyim.
