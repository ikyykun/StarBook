import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';
import 'dart:convert';
import 'package:starbook/data/profile_provider.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      final response = await ProfileProvider().fetchProfile();

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        print('Response body: $responseBody');

        // Periksa apakah responseBody adalah daftar
        if (responseBody is List) {
          // Ambil profil pertama dari daftar
          var profile = responseBody[0];
          String fetchedName = profile['name'];
          String fetchedEmail = profile['email'];

          SharedPreferences.getInstance().then((prefs) {
            SpUtil.putString('name', fetchedName);
            SpUtil.putString('email', fetchedEmail);
          });
        } else {
          print('Unexpected response format');
        }
      } else {
        print('Failed to fetch profile data');
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }
}
