import 'package:favorikitaplarim/models/book_models.dart';
import 'package:hive/hive.dart';

class BookHiveService {
  Future<List<BookModel>> loadFavoriteBooks() async {
    var box = await Hive.openBox<BookModel>('favorite_books');
    return box.values.toList();
  }

  Future<void> saveFavoriteBook(BookModel bookModel) async {
    var box = await Hive.openBox<BookModel>('favorite_books');
    await box.put(bookModel.id, bookModel);
  }

  Future<void> removeFavoriteBook(String id) async {
    var box = await Hive.openBox<BookModel>('favorite_books');
    await box.delete(id);
  }
}
