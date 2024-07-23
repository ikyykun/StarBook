import 'package:flutter/material.dart';
import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:starbook/Pinjam/pinjam_page.dart';
import 'package:starbook/models/books.dart';

class OverviewPage extends StatefulWidget {
  final Books book;

  const OverviewPage({super.key, required this.book});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 94, 113, 228),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'StarBook',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _posterJudul(context),
            _deskripsi(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 94, 113, 228),
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => PinjamPage(book_id: widget.book.id))));
                    },
                    child: const Text('Pinjam Sekarang !'),
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      'Stock',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 94, 113, 228),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${widget.book.stock}', // Menggunakan interpolasi string untuk stock
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _deskripsi() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 217, 217, 217),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: AnimatedReadMoreText(
              widget.book.overview ?? '',
              maxLines: 5,
              readMoreText: '...Selengkapnya',
              readLessText: '...Lebih Sedikit',
              animationCurve: Curves.bounceInOut,
              animationDuration: const Duration(milliseconds: 500),
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              buttonTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _posterJudul(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: widget.book.posterPath != null
                ? CachedNetworkImage(
                    imageUrl: widget.book.posterPath!,
                    width: MediaQuery.of(context).size.width,
                    height: 165,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.block,
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 165,
                    child: const Center(
                      child: Icon(Icons.block),
                    ),
                  ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Judul Buku:',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  widget.book.title,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Penulis:',
                  style: TextStyle(fontSize: 13),
                ),
                const Text(
                  'Lorem ipsum',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Penerbit:',
                  style: TextStyle(fontSize: 13),
                ),
                const Text(
                  'Lorem ipsum',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _header() {
    return const Text(
      'Deskripsi',
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
