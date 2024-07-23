import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import 'package:starbook/Home/main_home_page.dart';
import 'dart:convert';
import 'package:starbook/controller/login_controller.dart';

// Definisi kelas Post
class Post {
  final String? user_id;
  final String? book_id;
  final DateTime? rentalDate;
  final String? alamat;
  final int? qty; // Added qty parameter

  Post({
    required this.user_id,
    required this.book_id,
    required this.rentalDate,
    required this.alamat,
    required this.qty, // Added qty parameter
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      user_id: json['user_id'],
      book_id: json['book_id'],
      rentalDate: DateTime.parse(json['rentalDate']),
      alamat: json['alamat'],
      qty: json['qty'], // Added qty parameter
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'book_id': book_id,
      'rentalDate': rentalDate?.toIso8601String(),
      'alamat': alamat,
      'qty': qty, // Added qty parameter
    };
  }
}

class RequestController extends GetxController {
  final LoginController loginController = Get.find();

  // Fungsi untuk membuat post
  Future<Post?> createPost(String user_id, String book_id, DateTime rentalDate,
      String alamat, int qty) async {
    Post postRequest = Post(
      user_id: user_id,
      book_id: book_id,
      rentalDate: rentalDate,
      alamat: alamat,
      qty: qty, // Added qty parameter
    );

    print('Data yang akan dikirim: ${postRequest.toJson()}');

    final uri = Uri.parse("http://127.0.0.1:8000/api/rental/request");
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(uri,
        headers: headers, body: json.encode(postRequest.toJson()));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('Request successful');
      Get.off(const MainHomePage()); // Navigate to Home Page
      return Post.fromJson(responseData);
    } else {
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  }

  // Fungsi untuk mengambil daftar post
  Future<List<Post>> fetchPosts() async {
    try {
      final uri = Uri.parse("http://127.0.0.1:8000/api/rental/all");
      final headers = {'Content-Type': 'application/json'};
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        return responseData.map((data) => Post.fromJson(data)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  // Mendapatkan user_id dari SpUtil
  String? getUserId() {
    return SpUtil.getString('user_id');
  }

  // Contoh penggunaan fungsi fetchPosts
  Future<void> displayPosts() async {
    final posts = await fetchPosts();
    for (var post in posts) {
      print('Post: ${post.toJson()}');
    }
  }
}
