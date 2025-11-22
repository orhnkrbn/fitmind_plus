import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<void> init() async {
    // Firebase sadece Android, iOS ve Web'de çalışsın
    // Windows'ta skip et (Windows için Firebase desteği eksik)
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      await Firebase.initializeApp();
    }
  }
}
