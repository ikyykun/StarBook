import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import CachedNetworkImage
import 'package:starbook/Overview/overview_page.dart'; // Ensure proper import
import 'package:starbook/models/books.dart';
import 'package:starbook/controller/books_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Books>> books;

  @override
  void initState() {
    super.initState();
    books = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<Books>>(
            future: books,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Column(
                  children: [
                    _rekomendasi(),
                    _banner(snapshot.data ?? []),
                    const SizedBox(height: 10),
                    _popular(),
                    _moreKonten(snapshot.data ?? []),
                    _terlaris(),
                    _moreKonten(snapshot.data ?? []),
                    _pinjam(),
                    _moreKonten(snapshot.data ?? []),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _moreKonten(List<Books> books) {
    return SizedBox(
      height: 155,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          Books book = books[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OverviewPage(book: book),
                ),
              );
            },
            child: Container(
              width: 115,
              height: 155,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        '${book.posterPath}', // ini kena cors keknya tapi kek nya gak mungkin // kena cors ini bang
                    width: 115,
                    height: 155,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.block),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _banner(List<Books> books) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SizedBox(
            height: 187,
            width: 333,
            child: AnotherCarousel(
              images: books
                  .map((book) => NetworkImage(
                        '${book.posterPath}',
                      ))
                  .toList(),
              boxFit: BoxFit.fitWidth,
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.white,
              indicatorBgPadding: 5.0,
              moveIndicatorFromBottom: 50.0,
              noRadiusForIndicator: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _rekomendasi() {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            'Rekomendasi',
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _popular() {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 5),
          child: Text(
            'Popular',
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _terlaris() {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 5, top: 10),
          child: Text(
            'Terlaris',
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _pinjam() {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, bottom: 5, top: 10),
          child: Text(
            'Paling banyak di pinjam',
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
