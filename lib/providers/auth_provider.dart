import 'package:flutter/foundation.dart'; // <-- TAMBAHKAN BARIS INI

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _userEmail = '';

  bool get isAuthenticated => _isAuthenticated;
  String get userEmail => _userEmail;

  Future<bool> login(String email, String password) async {
    // Simulasi validasi login
    await Future.delayed(const Duration(seconds: 1));

    if (email.isNotEmpty && password.isNotEmpty && password.length >= 6) {
      _isAuthenticated = true;
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isAuthenticated = false;
    _userEmail = '';
    notifyListeners();
  }
}