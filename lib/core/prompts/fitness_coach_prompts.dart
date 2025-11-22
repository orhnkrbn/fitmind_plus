/// FitMind+ AI Prompt Paketi
/// 
/// Fitness koçu tarzında, Türkçe, motive edici promptlar
library;

/// Günlük motivasyon promptu
/// 
/// Kullanıcının günlük enerji seviyesine göre özelleştirilmiş motivasyon mesajı
/// 
/// Parametreler:
/// - {userName}: Kullanıcının adı
/// - {energyLevel}: düşük | orta | yüksek
/// - {dayOfWeek}: Pazartesi | Salı | ... | Pazar
const String dailyMotivationPrompt = '''
Sen profesyonel bir fitness koçusun. Kullanıcının adı {userName}.
Bugün {dayOfWeek} ve enerji seviyesi {energyLevel}.

Ona bugüne özel, kısa (2-3 cümle) ve motive edici bir mesaj yaz.
Mesajın samimi, dostça ve enerji dolu olsun. Emojiler kullanabilirsin.
Fitness hedeflerine odaklanmasını sağla ama baskı yapma.
''';

/// Antrenman önerisi promptu
/// 
/// Kullanıcının deneyim seviyesi ve hedeflerine göre antrenman önerisi
/// 
/// Parametreler:
/// - {userName}: Kullanıcının adı
/// - {fitnessLevel}: başlangıç | orta | ileri
/// - {goal}: kilo vermek | kas yapmak | dayanıklılık | esneklik
/// - {availableTime}: dakika cinsinden (örn: 30)
/// - {equipment}: var | yok
const String workoutSuggestionPrompt = '''
Sen uzman bir fitness koçusun. {userName} için antrenman planla.

Fitness seviyesi: {fitnessLevel}
Hedef: {goal}
Mevcut süre: {availableTime} dakika
Ekipman: {equipment}

Bu bilgilere göre:
1. Ona uygun 1 antrenman öner (isim + kısa açıklama)
2. 3-4 egzersiz listele (isim, set, tekrar)
3. Motivasyon notu ekle (1 cümle)

Cevabın kısa, net ve uygulanabilir olsun. Türkçe yaz.
''';

/// Beslenme tavsiyesi promptu
/// 
/// Kullanıcının beslenme hedefi ve alışkanlıklarına göre öneri
/// 
/// Parametreler:
/// - {userName}: Kullanıcının adı
/// - {goal}: kilo vermek | kilo almak | sağlıklı yaşam
/// - {currentMeals}: bugün yedikleri (örn: "kahvaltı: yumurta, öğle: salata")
/// - {waterIntake}: litre cinsinden
const String nutritionAdvicePrompt = '''
Sen diyetisyen ve fitness koçusun. {userName} için beslenme tavsiyesi ver.

Hedef: {goal}
Bugün yedikleri: {currentMeals}
Su tüketimi: {waterIntake} litre

Bu bilgilere göre:
1. Beslenme açısından eksikleri belirt (2 cümle)
2. Bir sonraki öğün önerisi ver (net ve basit)
3. Su tüketimi hakkında yorum yap (1 cümle)

Samimi, dostça ve yapıcı ol. Türkçe yaz.
''';

/// Haftalık rapor promptu
/// 
/// Kullanıcının haftalık performansını değerlendirme
/// 
/// Parametreler:
/// - {userName}: Kullanıcının adı
/// - {completedWorkouts}: tamamlanan antrenman sayısı
/// - {totalCalories}: yakılan toplam kalori
/// - {avgMoodScore}: ortalama ruh hali skoru (1-10)
/// - {goalProgress}: hedefe ilerleme yüzdesi
const String weeklyReportPrompt = '''
Sen kişisel fitness koçusun. {userName} için haftalık değerlendirme yap.

Bu hafta:
- Tamamlanan antrenman: {completedWorkouts}
- Yakılan kalori: {totalCalories} kcal
- Ortalama ruh hali: {avgMoodScore}/10
- Hedefe ilerleme: %{goalProgress}

Bu verilere göre:
1. Genel performans değerlendirmesi (2 cümle, övgüler)
2. Geliştirilecek 1 alan belirt
3. Gelecek hafta için net 1 hedef öner

Motive edici ve destekleyici ol. Türkçe yaz.
''';

/// Stres azaltma promptu
/// 
/// Kullanıcının stres seviyesine göre rahatlama önerileri
/// 
/// Parametreler:
/// - {userName}: Kullanıcının adı
/// - {stressLevel}: düşük | orta | yüksek
/// - {stressSource}: iş | aile | sağlık | genel
const String stressReliefPrompt = '''
Sen wellness koçu ve fitness uzmanısın. {userName} bugün stresli.

Stres seviyesi: {stressLevel}
Stres kaynağı: {stressSource}

Ona yardımcı ol:
1. Anlayış göster (1 cümle, empatik)
2. Hemen yapabileceği 1 nefes egzersizi öner (kısa tarif)
3. 10 dakikalık fiziksel aktivite öner (basit ve etkili)

Sakinleştirici, destekleyici ve umut verici ol. Türkçe yaz.
''';

/// Hedef takibi promptu
/// 
/// Kullanıcının hedefine olan mesafesini analiz etme
/// 
/// Parametreler:
/// - {userName}: Kullanıcının adı
/// - {goal}: hedef tanımı
/// - {currentValue}: mevcut değer (örn: 75 kg)
/// - {targetValue}: hedef değer (örn: 70 kg)
/// - {timeSpent}: başlangıçtan beri geçen gün
/// - {estimatedTimeLeft}: hedefe kalan tahmini gün
const String goalTrackingPrompt = '''
Sen kişisel gelişim ve fitness koçusun. {userName}'in hedefini takip et.

Hedef: {goal}
Mevcut: {currentValue}
Hedef değer: {targetValue}
Geçen süre: {timeSpent} gün
Tahmini kalan süre: {estimatedTimeLeft} gün

Bu verilere göre:
1. İlerleme değerlendirmesi (gerçekçi ve pozitif)
2. Motivasyon notu (hedefe yakınlığı vurgula)
3. Hızlandırma önerisi (1 pratik tavsiye)

İlham verici ve somut ol. Türkçe yaz.
''';

/// Prompt Yöneticisi
/// 
/// Promptları dinamik argümanlarla doldurup yöneten utility sınıf
class PromptManager {
  /// Tüm kullanılabilir promptlar
  static const Map<String, String> _prompts = {
    'dailyMotivation': dailyMotivationPrompt,
    'workoutSuggestion': workoutSuggestionPrompt,
    'nutritionAdvice': nutritionAdvicePrompt,
    'weeklyReport': weeklyReportPrompt,
    'stressRelief': stressReliefPrompt,
    'goalTracking': goalTrackingPrompt,
  };

  /// Prompt adına göre şablonu getir
  /// 
  /// Örnek:
  /// ```dart
  /// final prompt = PromptManager.getPrompt('dailyMotivation', {
  ///   'userName': 'Ahmet',
  ///   'energyLevel': 'yüksek',
  ///   'dayOfWeek': 'Pazartesi',
  /// });
  /// ```
  static String getPrompt(String name, Map<String, String> args) {
    final template = _prompts[name];
    if (template == null) {
      throw ArgumentError('Prompt bulunamadı: $name');
    }

    String result = template;
    args.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });

    return result;
  }

  /// Tüm prompt isimlerini listele
  static List<String> get availablePrompts => _prompts.keys.toList();

  /// Prompt var mı kontrol et
  static bool hasPrompt(String name) => _prompts.containsKey(name);

  /// Validasyon: Tüm gerekli argümanlar sağlandı mı?
  /// 
  /// Örnek:
  /// ```dart
  /// final missing = PromptManager.validateArgs('dailyMotivation', {
  ///   'userName': 'Ahmet',
  /// });
  /// print(missing); // ['energyLevel', 'dayOfWeek']
  /// ```
  static List<String> validateArgs(String name, Map<String, String> args) {
    final template = _prompts[name];
    if (template == null) return [];

    final required = <String>[];
    final pattern = RegExp(r'\{(\w+)\}');
    final matches = pattern.allMatches(template);

    for (final match in matches) {
      final key = match.group(1)!;
      if (!required.contains(key)) {
        required.add(key);
      }
    }

    return required.where((key) => !args.containsKey(key)).toList();
  }

  /// Hızlı prompt oluşturucu yardımcıları
  
  /// Günlük motivasyon oluştur
  static String dailyMotivation({
    required String userName,
    required String energyLevel,
    required String dayOfWeek,
  }) {
    return getPrompt('dailyMotivation', {
      'userName': userName,
      'energyLevel': energyLevel,
      'dayOfWeek': dayOfWeek,
    });
  }

  /// Antrenman önerisi oluştur
  static String workoutSuggestion({
    required String userName,
    required String fitnessLevel,
    required String goal,
    required String availableTime,
    required String equipment,
  }) {
    return getPrompt('workoutSuggestion', {
      'userName': userName,
      'fitnessLevel': fitnessLevel,
      'goal': goal,
      'availableTime': availableTime,
      'equipment': equipment,
    });
  }

  /// Beslenme tavsiyesi oluştur
  static String nutritionAdvice({
    required String userName,
    required String goal,
    required String currentMeals,
    required String waterIntake,
  }) {
    return getPrompt('nutritionAdvice', {
      'userName': userName,
      'goal': goal,
      'currentMeals': currentMeals,
      'waterIntake': waterIntake,
    });
  }

  /// Haftalık rapor oluştur
  static String weeklyReport({
    required String userName,
    required String completedWorkouts,
    required String totalCalories,
    required String avgMoodScore,
    required String goalProgress,
  }) {
    return getPrompt('weeklyReport', {
      'userName': userName,
      'completedWorkouts': completedWorkouts,
      'totalCalories': totalCalories,
      'avgMoodScore': avgMoodScore,
      'goalProgress': goalProgress,
    });
  }

  /// Stres azaltma önerisi oluştur
  static String stressRelief({
    required String userName,
    required String stressLevel,
    required String stressSource,
  }) {
    return getPrompt('stressRelief', {
      'userName': userName,
      'stressLevel': stressLevel,
      'stressSource': stressSource,
    });
  }

  /// Hedef takibi oluştur
  static String goalTracking({
    required String userName,
    required String goal,
    required String currentValue,
    required String targetValue,
    required String timeSpent,
    required String estimatedTimeLeft,
  }) {
    return getPrompt('goalTracking', {
      'userName': userName,
      'goal': goal,
      'currentValue': currentValue,
      'targetValue': targetValue,
      'timeSpent': timeSpent,
      'estimatedTimeLeft': estimatedTimeLeft,
    });
  }
}
