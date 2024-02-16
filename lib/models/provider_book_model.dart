import 'package:favorikitaplarim/models/book_models.dart';
import 'package:favorikitaplarim/services/hive.dart';
import 'package:flutter/material.dart';

class ProviderBookModel extends ChangeNotifier {
  final List<BookModel> _secilenkitaplar = [];
  final BookHiveService _bookService = BookHiveService();

  List<BookModel> get secilenkitaplar => _secilenkitaplar;

  ProviderBookModel() {
    _loadFromHive();
  }

  void bookAdd(BookModel bookModel) async {
    _secilenkitaplar.add(bookModel);
    notifyListeners();
    await _bookService.saveFavoriteBook(bookModel);
  }

  void bookRemove(BookModel bookModel) async {
    _secilenkitaplar.removeWhere((book) => book.id == bookModel.id);
    notifyListeners();
    await _bookService.removeFavoriteBook(bookModel.id);
  }

  Future<void> _loadFromHive() async {
    List<BookModel> favoriteBooks = await _bookService.loadFavoriteBooks();
    _secilenkitaplar.addAll(favoriteBooks);
    notifyListeners();
  }
}
