import 'package:flutter/material.dart';
import 'package:starbook/Overview/overview_page.dart';
import 'package:starbook/models/books.dart';
import 'package:starbook/controller/books_controller.dart';
// import 'package:starbook/Overview/overview_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Books>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Books>>(
          future: _booksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _text1(),
                    _moreKonten(snapshot.data ?? []),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Padding _text1() {
    return const Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Text(
        'History',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _moreKonten(List<Books> books) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        shrinkWrap: true, // Ensures the ListView takes only the space it needs
        physics:
            const NeverScrollableScrollPhysics(), // Disable scrolling of the ListView
        itemCount: books.length,
        itemBuilder: (context, index) {
          Books movie = books[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OverviewPage(book: books[index]),
                ),
              );
            },
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
                          '${movie.posterPath}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.title,
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
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Anda telah mengembalikan buku ini',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: "Poppins",
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
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
}

// // Dummy Books class and fetchMovies function for completeness
// class Books {
//   final String title;
//   final String posterPath;

//   Books(this.title, this.posterPath);
// }

// Future<List<Books>> fetchMovies() async {
//   // Mock data
//   await Future.delayed(const Duration(seconds: 2));
//   return [
//     Books('Books 1', '/path_to_image1.jpg'),
//     Books('Books 2', '/path_to_image2.jpg'),
//     // Add more books as needed
//   ];
// }
