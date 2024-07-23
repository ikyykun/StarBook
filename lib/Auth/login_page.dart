import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';
import 'package:starbook/controller/login_controller.dart';
import 'package:starbook/Auth/create_page.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 94, 113, 228),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 200),
                  child: Text(
                    'StarBook',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3.5,
            left: MediaQuery.of(context).size.width / 6,
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: Column(
                    children: [
                      const Text(
                        'Masuk',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text('${SpUtil.getString('email')}'),
                      TextFormField(
                        controller: controller.txtUsername,
                        decoration: const InputDecoration(
                          hintText: 'Nama Pengguna',
                          hintStyle: TextStyle(fontSize: 10),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: controller.txtPassword,
                        decoration: const InputDecoration(
                          hintText: 'Kata Sandi',
                          hintStyle: TextStyle(fontSize: 10),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => controller.auth(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5E71E4),
                          fixedSize: const Size(140, 33),
                        ),
                        child: const Text(
                          'MASUK',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum Punya Akun?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreatePage()),
                    );
                  },
                  child: const Text(
                    'Buat Akun Anda',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
