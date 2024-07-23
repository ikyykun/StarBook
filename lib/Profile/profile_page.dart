import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:sp_util/sp_util.dart';
import 'package:starbook/Auth/login_page.dart';
import 'package:starbook/models/books.dart';
import 'package:get/get.dart'; // Import Get for navigation

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<Books>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text("Profile"),
      headerWidget: headerWidget(context),
      body: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Riwayat peminjaman',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        FutureBuilder<List<Books>>(
          future: _booksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No books found.'));
            } else {
              return listView(snapshot.data!);
            }
          },
        ),
      ],
      fullyStretchable: true,
      backgroundColor: Colors.white,
      appBarColor: const Color.fromARGB(255, 94, 113, 228),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      height: 200,
      color: const Color.fromARGB(255, 94, 113, 228),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                    child: Text('AB'),
                  ),
                  Text('${SpUtil.getString('name')}'),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 94, 113, 228),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    child: const Text('Edit Profile'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: logout,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    child: const Text('Log Out'),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listView(List<Books> books) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        shrinkWrap: true, // Ensures the ListView takes only the space it needs
        physics:
            const NeverScrollableScrollPhysics(), // Disable scrolling of the ListView
        itemCount: books.length,
        itemBuilder: (context, index) {
          Books book = books[index];
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
                      image: DecorationImage(
                        image: NetworkImage(
                          '${book.posterPath}',
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
                        Text(
                          book.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Anda telah mengembalikan buku ini',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: "Poppins",
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Kondisi',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        105,
                                        228,
                                        94,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      'Belum Dikembalikan',
                                      style: TextStyle(
                                        fontSize: 7,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Biaya',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        105,
                                        228,
                                        94,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Text(
                                      'Belum Dikembalikan',
                                      style: TextStyle(
                                        fontSize: 7,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<Books>> fetchBooks() async {
    // Add your logic to fetch books here
    // For demonstration, returning an empty list
    return [];
  }

  void logout() async {
    // Clear stored user information
    await SpUtil.clear();

    // Navigate to the login page
    Get.offAll(() => const LoginPage());
  }
}
