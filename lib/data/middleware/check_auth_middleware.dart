import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getTokenAndUseIt() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString(
      'Token'); // Assuming 'token' is the key used to store the token.

  if (token != null) {
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    if (JwtDecoder.isExpired(token)) {
      return "Token Expired";
    } else {


    
      return token;
    }
  } else {
    return null;
  }
}
