import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loader_overlay/loader_overlay.dart';

class UserModel {
  String? fullname;
  String? email;
  String? phone;
  String? refresh;
  String? access;

  UserModel({
    this.fullname,
    this.email,
    this.phone,
    this.refresh,
    this.access,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    if (json['tokens'] != null) {
      refresh = json['tokens']['refresh'];
      access = json['tokens']['access'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['email'] = email;
    data['phone'] = phone;
    if (data['tokens'] != null) {
      data['tokens']['refresh'] = refresh;
      data['tokens']['access'] = access;
    }
    return data;
  }
}

/*


Request Class


*/
class GoogleAuth {
  static String lgoinUrl = 'https://tryer.up.railway.app/api/login/';
  static GoogleSignIn googleSignIn = GoogleSignIn();

  static Future googlelogin(BuildContext context) async {
    try {
      // Attempt to sign in the user with Google.
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // If the sign in wa s successful, get the access token.
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final String? accessToken = googleAuth.accessToken;

      Map<String, dynamic> body = {'access_token': accessToken};

      http.Response response = await http.post(
        Uri.parse(lgoinUrl),
        body: json.encode(body),
        headers: {"Content-Type": 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        UserModel user = UserModel.fromJson(responseData);
        context.loaderOverlay.hide();
        return {
          'status': true,
          'data': user,
        };
      } else {
        var responseData = json.decode(response.body);
        context.loaderOverlay.hide();
        return {
          'status': false,
          'message': responseData['message'],
        };
      }
    } catch (error) {
      context.loaderOverlay.hide();
      print("$error");
    }
  }

  static Future signout(BuildContext context) async {
    await googleSignIn.signOut();
    await googleSignIn.disconnect();
  }
}
