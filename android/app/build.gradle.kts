plugins {
    id("com.android.application")
<<<<<<< HEAD
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.fitmind_plus_ultra_22"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.fitmind_plus_ultra_22"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
=======
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services") // Firebase/Google Sign-In kullanıyorsan
}

android {
    namespace = "com.example.fitmind_plus"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.fitmind_plus"
        minSdk = 21
        targetSdk = 34

        // Flutter’ın versionCode / versionName okuması için:
        val localProps = java.util.Properties().apply {
            val f = file("${rootDir}/local.properties")
            if (f.exists()) f.inputStream().use { load(it) }
        }
        val flutterVersionCode = (localProps.getProperty("flutter.versionCode") ?: "1").toInt()
        val flutterVersionName = localProps.getProperty("flutter.versionName") ?: "1.0"

        versionCode = flutterVersionCode
        versionName = flutterVersionName
>>>>>>> 6058be767d13b06871003f218e445296ac021be6
    }

    buildTypes {
        release {
<<<<<<< HEAD
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
=======
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            // debug ayarları
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }

    packaging {
        resources {
            excludes += setOf(
                "META-INF/AL2.0",
                "META-INF/LGPL2.1"
            )
>>>>>>> 6058be767d13b06871003f218e445296ac021be6
        }
    }
}

<<<<<<< HEAD
flutter {
    source = "../.."
=======
// Flutter bağımlılıklarını Flutter gradle dosyası yönetecek.
// Buraya kendi ek bağımlılıklarını koyabilirsin:
dependencies {
    // örn: implementation("androidx.core:core-ktx:1.13.1")
>>>>>>> 6058be767d13b06871003f218e445296ac021be6
}
