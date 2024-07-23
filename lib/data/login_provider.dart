import 'package:get/get.dart';

class LoginProvider extends GetConnect {
  Future<Response> auth(var data) {
    var myHeader = {'Accept': 'application/json'};
    return post('http://127.0.0.1:8000/api/login/auth', data,
        headers: myHeader);
  }
}
