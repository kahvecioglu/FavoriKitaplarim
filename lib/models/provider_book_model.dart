import 'package:favorikitaplarim/models/book_models.dart';
import 'package:flutter/material.dart';
import 'package:favorikitaplarim/models/book_models.dart';

class ProviderBookModel extends ChangeNotifier {
  List<BookModel> _secilenkitaplar = [];

  List<BookModel> get secilenkitaplar => _secilenkitaplar;

  void KitapSec(BookModel bookModel) {
    _secilenkitaplar.add(bookModel);
    notifyListeners();

    void KitapSil(BookModel bookModel) {
      _secilenkitaplar.remove(bookModel);
      notifyListeners();
    }
  }
}
