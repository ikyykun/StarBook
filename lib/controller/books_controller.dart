// services/books_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/books.dart';

Future<List<Books>> fetchBooks() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/buku/all'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Books.fromJson(json)).toList();
  } else {
    throw Exception('Gagal memuat data buku');
  }
}
