import 'package:get/get.dart';

class ProfileProvider extends GetConnect {
  Future<Response> auth() {
    var myHeader = {'Accept': 'application/json'};
    return get('http://127.0.0.1:8000/api/user/all', headers: myHeader);
  }

  fetchProfile() {}
}
