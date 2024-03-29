class BookModel {
  final String title;
  final String authors;
  final String publisher;
  final String publishedDate;
  final String pageCount;
  final String thumbnail;
  final String id;

  BookModel({
    required this.title,
    required this.authors,
    required this.pageCount,
    required this.publishedDate,
    required this.publisher,
    required this.thumbnail,
    required this.id,
  });
}
