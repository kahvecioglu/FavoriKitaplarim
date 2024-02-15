import 'package:favorikitaplarim/models/book_models.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProviderBookModel extends ChangeNotifier {
  final List<BookModel> _secilenkitaplar = [];

  List<BookModel> get secilenkitaplar => _secilenkitaplar;

  ProviderBookModel() {
    _loadFromHive(); // Uygulama başladığında favori kitapları yükle
  }

  void bookAdd(BookModel bookModel) {
    _secilenkitaplar.add(bookModel);
    notifyListeners();
    _saveToHive(bookModel); // Favorilere eklenen kitabı Hive'a kaydet
  }

  void bookRemove(BookModel bookModel) {
    _secilenkitaplar.removeWhere((book) => book.id == bookModel.id);
    notifyListeners();
    _removeFromHive(
        bookModel.id); // Favorilerden kaldırılan kitabı Hive den sil
  }

  Future<void> _loadFromHive() async {
    var box = await Hive.openBox<BookModel>('favorite_books');
    _secilenkitaplar.addAll(box.values.cast<
        BookModel>()); // Box'tan gelen verileri BookModel listesine dönüştürerek ekle
    notifyListeners();
  }

  Future<void> _saveToHive(BookModel bookModel) async {
    var box = await Hive.openBox<BookModel>('favorite_books');
    await box.put(bookModel.id, bookModel);
  }

  Future<void> _removeFromHive(String id) async {
    var box = await Hive.openBox<BookModel>('favorite_books');
    await box.delete(id);
  }
}
