import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';
import 'package:starbook/controller/request_controller.dart';

class PinjamPage extends StatefulWidget {
  final int book_id; // Accept book_id as a parameter

  const PinjamPage({super.key, required this.book_id});

  @override
  State<PinjamPage> createState() => PinjamPageState();
}

class PinjamPageState extends State<PinjamPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController(text: '0');
  DateTime _selectedDate = DateTime.now();
  final RequestController _requestController = Get.put(RequestController());

  @override
  void initState() {
    super.initState();
    _selectedBookId = widget.book_id.toString(); // Set the selected book ID
  }

  String? _selectedBookId;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      int? book_id = int.tryParse(_selectedBookId!);
      String alamat = _alamatController.text;
      int qty = int.parse(_qtyController.text);

      if (book_id != null) {
        String user_id = _requestController.getUserId() ?? '1';
        print('Retrieved user ID: $user_id'); // Logging the user ID

        Post? post = await _requestController.createPost(
          user_id,
          book_id.toString(),
          _selectedDate,
          alamat,
          qty,
        );

        if (post != null) {
          print('Request successfully sent to admin: ${post.toJson()}');
        } else {
          print('Failed to send request');
        }
      } else {
        print('Please select a book');
      }
    }
  }

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Pinjam Sekarang',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        // Display the selected book title (since we are not fetching books here)
                        Text(
                          'Book ID: ${widget.book_id}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _alamatController,
                          decoration: const InputDecoration(
                            hintText: 'Alamat',
                            hintStyle: TextStyle(fontSize: 10),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        InputQty(
                          maxVal: 100,
                          initVal: 0,
                          minVal: 0,
                          steps: 1,
                          onQtyChanged: (val) {
                            setState(() {
                              _qtyController.text = val.toString();
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () => _selectDate(context),
                          child: Text(
                            'Select Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5E71E4),
                            fixedSize: const Size(140, 33),
                          ),
                          child: const Text(
                            'REQUEST',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
