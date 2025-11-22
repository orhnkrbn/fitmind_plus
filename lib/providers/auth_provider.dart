// lib/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_user.dart' as models;

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _globalLoading = false;
  bool get globalLoading => _globalLoading;

  User? get user => _auth.currentUser;
  User? get firebaseUser => _auth.currentUser;

  models.AppUser? get profile => firebaseUser == null
      ? null
      : models.AppUser(
          uid: firebaseUser!.uid,
          email: firebaseUser!.email ?? '',
          name: firebaseUser!.displayName,
          photoUrl: firebaseUser!.photoURL,
          createdAt: firebaseUser!.metadata.creationTime ?? DateTime.now(),
        );

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  void _setLoading(bool v) {
    _globalLoading = v;
    notifyListeners();
  }

  Future<String?> signInWithEmail(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Giriş başarısız';
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      _setLoading(true);
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (displayName != null && displayName.isNotEmpty) {
        await cred.user?.updateDisplayName(displayName);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Kayıt başarısız';
    } finally {
      _setLoading(false);
    }
  }

  /// Google ile giriş
  Future<String?> signInWithGoogle() async {
    try {
      _setLoading(true);

      if (kIsWeb) {
        // ✅ Web: doğrudan Firebase popup (google_sign_in'e gerek yok)
        final provider = GoogleAuthProvider();
        await _auth.signInWithPopup(provider);
        return null;
      } else {
        // 🟡 Mobil/desktop: Şimdilik devre dışı. İstersek sonra ekleriz.
        return 'Google ile giriş mobil/desktop için henüz eklenmedi.';
      }
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Google ile giriş başarısız';
    } catch (e) {
      return e.toString();
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  bool get isAppleAvailable =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);

  Future<String?> signInWithApple() async {
    if (!isAppleAvailable) {
      return 'Bu platformda Apple ile giriş desteklenmiyor.';
    }
    return 'Apple sign-in henüz yapılandırılmadı.';
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } finally {
      notifyListeners();
    }
  }
}
