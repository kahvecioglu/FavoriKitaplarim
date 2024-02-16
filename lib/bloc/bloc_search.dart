import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchBloc {
  final _searchResultsController =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get searchResults =>
      _searchResultsController.stream;

  void searchBooks(String term, BuildContext context) async {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$term'),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['items'];

      if (responseData != null) {
        _searchResultsController.sink
            .add(List<Map<String, dynamic>>.from(responseData));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Center(
              child: Text(
                "Lütfen Geçerli Bir Terim Giriniz",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      }
    } else {
      _searchResultsController.sink
          .addError("Kitaplar yüklenirken bir sorun oluştu");
    }
  }

  void clearSearchResults() {
    _searchResultsController.sink.add([]);
  }
}
