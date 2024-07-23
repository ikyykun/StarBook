import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:starbook/controller/borrow_controller.dart'; // Ensure this import is correct based on your project structure

class BorrowPage extends StatefulWidget {
  const BorrowPage({Key? key}) : super(key: key);

  @override
  State<BorrowPage> createState() => _BorrowPageState();
}

class _BorrowPageState extends State<BorrowPage> {
  final RentalService rentalService =
      RentalService(); // Initialize your RentalService
  late Future<List<Rental>>
      rentalData; // Future to hold the list of Rental data

  @override
  void initState() {
    super.initState();
    rentalData =
        _fetchRentalData(); // Initialize rentalData with the fetch function
  }

  Future<List<Rental>> _fetchRentalData() async {
    try {
      // Replace 'user_id' with your actual logic to get user ID from shared preferences or wherever it's stored
      String userId = await rentalService.getUserIdFromPreferences();
      List<Rental> rentals = await rentalService.getRentalData(userId);
      return rentals;
    } catch (e) {
      // Handle error as per your app's requirement
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<Rental>>(
            future: rentalData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _text1(),
                    _moreKonten(snapshot.data!),
                  ],
                );
              } else {
                return const Center(child: Text('No rental data available'));
              }
            },
          ),
        ),
      ),
    );
  }

  Padding _text1() {
    return const Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Text(
        'Pinjam',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _moreKonten(List<Rental> rentals) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: rentals.length,
          itemBuilder: (context, index) {
            Rental rental = rentals[index];
            return GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 139,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 215, 211, 211),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 139,
                      decoration: BoxDecoration(
                        // You can uncomment and customize this section for image decoration if needed
                        // borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            rental.cover_url,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              rental.judul,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            'Buku belum dikembalikan',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                          ),
                          Text(
                            '${rental.rental_date} - ${rental.rental_deadline}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      const Color.fromARGB(255, 94, 113, 228),
                                  fixedSize: const Size(70, 20),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  Get.snackbar("Kembalikan",
                                      "Segera ke perpustakaan yaa",
                                      backgroundColor:
                                          Color.fromARGB(255, 41, 56, 142),
                                      colorText: Colors.white);
                                },
                                child: const Text(
                                  'Kembalikan',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                width: 70,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 105, 228, 94),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  '${rental.qty}',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                width: 80,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 105, 228, 94),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  'Belum Dikembalikan',
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
