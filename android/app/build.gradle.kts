plugins {
    id("com.android.application")
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
    }

    buildTypes {
        release {
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
        }
    }
}

// Flutter bağımlılıklarını Flutter gradle dosyası yönetecek.
// Buraya kendi ek bağımlılıklarını koyabilirsin:
dependencies {
    // örn: implementation("androidx.core:core-ktx:1.13.1")
}
