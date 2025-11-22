# FitMind+ Web (PWA) Kurulum ve Geliştirme Planı

Bu belge, FitMind+ uygulamasının web tabanlı (PWA) sürümünü sıfırdan
oluştururken izlenebilecek adımları Türkçe olarak sadeleştirir. Adımlar, proje
altyapısının hazırlanmasından üretim derlemesine kadar olan süreci kapsar.

## 1. Proje Yapısını Oluştur (Vite + React + TypeScript)
- Yeni bir Vite projesi içinde React ve TypeScript yapılandırmasını başlat.
- `src/`, `components/`, `pages/`, `api/`, `assets/` gibi klasörleri tanımlayarak
dosya sistemini hazırla.

## 2. Vite React TypeScript Projesini Başlat
- Terminalde `npm create vite@latest fitmind-plus -- --template react-ts`
komutunu çalıştır.
- Bu komut FitMind+ adıyla React + TypeScript kullanan temel bir proje
iskeletti oluşturur.

## 3. Bolt Database Şemasını Tanımla
- Aşağıdaki veri tablolarını veya koleksiyonlarını belirle:
  - `users`: Kullanıcı hesap bilgileri.
  - `workouts`: Antrenman kayıtları.
  - `nutrition`: Beslenme kayıtları.
  - `progress`: Vücut ölçümleri, kilo ve grafik verileri.
  - `achievements`: Rozet, seviye ve başarı kayıtları.

## 4. Kimlik Doğrulama Sistemini Kur
- Bolt (veya Supabase) Auth kullanarak kayıt, giriş ve şifre sıfırlama
özellikleri ekle.
- JWT tabanlı güvenli oturum yönetimiyle kullanıcıların giriş yapmasını sağla.

## 5. OpenAI Edge Function ile AI Motivasyonunu Etkinleştir
- OpenAI API anahtarını sunucu tarafında saklayarak Edge Function oluştur.
- Bu fonksiyon günlük motivasyon mesajları, kişisel tavsiyeler ve ruh hâli
analizleri üretir.

## 6. Açılış (Splash) Ekranını Tasarla
- Uygulama açılırken kısa bir yükleme ekranı göster.
- Animasyonlu bir arka plan ve motivasyon sözü ekle. Örn: "Bugün yeni bir
başlangıç yap!"

## 7. Onboarding Akışını Hazırla
- Yeni kullanıcılar için üç adımlı bir tanıtım akışı oluştur:
  1. Hedef belirleme (kilo, kas, fit görünüm).
  2. Beslenme ve egzersiz sistemi.
  3. AI destekli motivasyon özellikleri.

## 8. "Body & Training" Sekmesini Geliştir
- Günlük/haftalık ilerleme halkaları ve kas gelişimi istatistiklerini göster.
- AI tarafından üretilen özel ipuçlarını sun.

## 9. "Mind & Motivation" Sekmesini Geliştir
- AI koç sohbet arayüzü ekle.
- Stres analizi, motivasyon mesajları ve ilham verici alıntılar paylaş.

## 10. "Nutrition & Progress" Sekmesini Geliştir
- Beslenme, kalori ve su tüketimi verilerini grafiklerle sun.
- Su içme takibi ile gün sonunda rozet kazanma senaryoları ekle.

## 11. Oyunlaştırma Sistemini Entegre Et
- XP, seviyeler, rozetler ve ardışık gün (streak) ödülleri tanımla.
- Örn: "3 gün üst üste antrenman → Streak Bonus +50XP" veya "1000 kalori yaktın
→ Level Up!".

## 12. Animasyon ve Mikro Etkileşimler Ekle
- Buton geçişleri, başarı kutlamaları ve sayfa geçişlerine yumuşak animasyonlar
koy.
- Rozet kazanıldığında konfeti animasyonu gibi mikro etkileşimler ekle.

## 13. Ses Efektleri ve Müzik Sistemi Ekle
- Başarı kazanıldığında veya antrenman tamamlandığında kısa ses efektleri
çal.
- İsteğe bağlı motivasyon müziklerini yönet.

## 14. PWA Özelliklerini Yapılandır
- Çevrimdışı çalışma ve "ana ekrana ekle" yeteneklerini etkinleştir.
- Manifest dosyası ve service worker yapılandırmasını tamamla.

## 15. Test Et ve Üretim Derlemesi Al
- Kimlik doğrulama, AI yanıtları ve grafik bileşenleri dahil tüm özellikleri
test et.
- `npm run build` komutuyla üretim paketini oluştur ve Vercel gibi bir
platforma dağıt.

## Özet
- AI tabanlı motivasyon sistemi.
- Modüler arayüz sekmeleri.
- Kullanıcı takibi ve oyunlaştırma.
- PWA olarak çevrimdışı ve yüklenebilir deneyim.
