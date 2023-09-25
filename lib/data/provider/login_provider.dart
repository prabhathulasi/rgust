import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:rugst_alliance_academia/routes/named_routes.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';

import 'package:rugst_alliance_academia/util/api_service.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Response> login(String email, String password) async {
    setLoading(true);
    // Make your login API call here using the http package

  
        var result = await ApiHelper.post("login", {"email": email, "password": password});
        return result;
      


     
      
       
      
 
    
  
  }
  Future<void> validate(BuildContext context) async {
    setLoading(true);
    // Make your login API call here using the http package

  
        ApiHelper.get("validate" )
        .then((value) {
      setLoading(false);
       if(value.statusCode == 200){
Fluttertoast.showToast(msg: "Token valid");
     }else{
      Navigator.pushNamed(context,  RouteNames.login);
     }
      
    }).catchError((onError) {
      setLoading(false);
      log(onError.toString());
      // Fluttertoast.showToast(msg: onError.toString());
    });
    
  
  }

  void setLoading(bool value) async {
    _isLoading = value;
    notifyListeners();
  }
}
