// models/books.dart
class Books {
  final String? overview;
  final String title;
  final String? posterPath;
  final double? popularity;
  final int? stock;
  final int id;

  Books({
    required this.title,
    this.posterPath,
    this.overview,
    this.popularity,
    this.stock,
    required this.id,
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      title: json['judul'],
      overview: json['deskripsi'],
      posterPath: json['cover_url'],
      popularity: (json['avg_ratings'] as num?)?.toDouble(),
      stock: json['qty'] as int?,
      id: json['id'] as int,
    );
  }
}
