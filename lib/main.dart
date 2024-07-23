import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:starbook/Auth/login_page.dart';
import 'package:starbook/Home/main_home_page.dart';
import 'package:starbook/Profile/profile_page.dart';
import 'package:starbook/controller/login_controller.dart';
// import 'package:starbook/controller/profile_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  // Register LoginController
  Get.put(LoginController());

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    getPages: [
      GetPage(
        name: '/home',
        page: () => const MainHomePage(),
      ),
      GetPage(
        name: '/login',
        page: () => const LoginPage(),
      ),
      GetPage(
        name: '/profile',
        page: () => const ProfilePage(),
      ),
      // GetPage(
      //   name: '/pinjam',
      //   page: () => const PinjamPage(bookId: widget.book.id),
      // ),
    ],
  ));
}
