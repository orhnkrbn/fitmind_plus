import java.util.Properties

plugins {
    id("com.android.application") version "8.2.2" apply false
    id("com.android.library") version "8.2.2" apply false
    id("org.jetbrains.kotlin.android") version "1.9.24" apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
}

val localProps = Properties().apply {
    val f = file("${rootDir}/local.properties")
    if (f.exists()) f.inputStream().use { load(it) }
}
val flutterSdk = localProps.getProperty("flutter.sdk")
    ?: throw GradleException("`flutter.sdk` local.properties içinde bulunamadı. Flutter SDK yolunu ekleyin.")

apply(from = "$flutterSdk/packages/flutter_tools/gradle/flutter.gradle")
