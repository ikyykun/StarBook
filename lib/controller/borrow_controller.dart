import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

class Rental {
  final int id;
  final int user_id;
  final String rental_date;
  final String rental_deadline;
  final int qty;
  final String judul;
  final String cover_url;

  Rental({
    required this.id,
    required this.user_id,
    required this.rental_date,
    required this.rental_deadline,
    required this.qty,
    required this.judul,
    required this.cover_url,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      id: json['id'],
      user_id: json['user_id'],
      rental_date: json['rental_date'],
      rental_deadline: json['rental_deadline'],
      qty: json['qty'],
      judul: json['buku']['judul'],
      cover_url: json['buku']['cover_url'],
    );
  }

  @override
  String toString() {
    return 'Rental{id: $id, userId: $user_id, rental_date: $rental_date, rental_deadline: $rental_deadline, qty: $qty, judul: $judul, cover_url: $cover_url}';
  }
}

class RentalService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Rental>> getRentalData(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/rental/$userId/get'));

    if (response.statusCode == 200) {
      print('Raw JSON response: ${response.body}'); // Debug print

      // Decode the JSON response
      final Map<String, dynamic> decodedJson = json.decode(response.body);

      print('Decoded JSON response: $decodedJson'); // Print the decoded JSON

      // Extract the list of rentals from the JSON map
      if (decodedJson.containsKey('data')) {
        List<dynamic> jsonList = decodedJson['data'];
        List<Rental> rentals = jsonList.map((json) => Rental.fromJson(json)).toList();
        return rentals;
      } else {
        throw Exception('Expected key "data" not found in response');
      }
    } else {
      throw Exception('Failed to load rental data');
    }
  }

  Future<String> getUserIdFromPreferences() async {
    final userId = SpUtil.getString('user_id') ?? '';
    if (userId.isEmpty) {
      throw Exception('User ID not found in shared preferences');
    }
    return userId;
  }

  Future<void> printAllRentalData() async {
    try {
      String userId = await getUserIdFromPreferences();
      List<Rental> rentals = await getRentalData(userId);
      rentals.forEach((rental) => print(rental));
    } catch (e) {
      print('Error printing rental data: $e');
    }
  }
}

void main() {
  RentalService rentalService = RentalService();
  rentalService.printAllRentalData();
}
