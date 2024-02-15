import 'package:favorikitaplarim/models/book_models.dart';
import 'package:flutter/material.dart';

class ProviderBookModel extends ChangeNotifier {
  final List<BookModel> _secilenkitaplar = [];

  List<BookModel> get secilenkitaplar => _secilenkitaplar;

  void kitapSec(BookModel bookModel) {
    _secilenkitaplar.add(bookModel);
    notifyListeners();
  }

  void kitapSil(BookModel bookModel) {
    _secilenkitaplar.removeWhere((book) => book.id == bookModel.id);
    notifyListeners();
  }
}
