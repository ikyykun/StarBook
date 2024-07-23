import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';
import 'package:starbook/data/login_provider.dart';

class LoginController extends GetxController {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _checkAutoLogin();
  }

  void _checkAutoLogin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');
      String? password = SpUtil.getString('password');
      if (username != null && password != null) {
        txtUsername.text = username;
        txtPassword.text = password;
        _autoLogin(username, password);
      }
    } catch (e) {
      print("Error checking auto login: $e");
    }
  }

  void _autoLogin(String username, String password) {
    var data = {'username': username, 'password': password};

    LoginProvider().auth(data).then((value) {
      var statusCode = value.statusCode;
      if (statusCode == 200) {
        Get.snackbar("Success", "Auto-login berhasil",
            backgroundColor: Colors.green, colorText: Colors.white);
        // Navigate to the next page or handle successful login
        Get.offAllNamed('/home');
      } else {
        Get.snackbar("Error", "Auto-login gagal",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }).catchError((error) {
      print("Error during auto login: $error");
    });
  }

  void auth() {
    String username = txtUsername.text;
    String password = txtPassword.text;
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Nama pengguna dan kata sandi tidak boleh kosong",
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      var data = {'username': username, 'password': password};

      LoginProvider().auth(data).then((value) async {
        var statusCode = value.statusCode;
        if (statusCode == 200) {
          var responseBody = value.body;

          // Print the entire response body
          print("Response Body: $responseBody");

          // Ensure responseBody and userData are not null
          if (responseBody != null && responseBody['data'] != null) {
            var userData = responseBody['data'];
            print("User Data: $userData");

            int user_id = userData['id'];
            print("User ID: $user_id");

            try {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('username', username);
              SpUtil.putString('password', password);
              await prefs.setString(
                  'user_id', user_id.toString()); // Convert user_id to String

              Get.snackbar("Success", "Login berhasil",
                  backgroundColor: Colors.green, colorText: Colors.white);
              Get.offAllNamed('/home');
            } catch (e) {
              print("Error saving login data: $e");
              Get.snackbar(
                  "Error", "Terjadi kesalahan saat menyimpan data login",
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
          } else {
            Get.snackbar("Error", "Response data tidak valid",
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        } else {
          Get.snackbar("Error", "Login gagal",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }).catchError((error) {
        print("Error during login: $error");
        Get.snackbar("Error", "Terjadi kesalahan saat login",
            backgroundColor: Colors.red, colorText: Colors.white);
      });
    }
  }

  Future<String?> getUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('user_id');
    } catch (e) {
      print("Error getting user ID: $e");
      return null;
    }
  }
}
