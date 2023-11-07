import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class AuthService {
// API Auth Service


  signup(String email, String password) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
