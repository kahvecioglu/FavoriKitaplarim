import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchBloc {
  final _searchResultsController =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get searchResults =>
      _searchResultsController.stream;

  void searchBooks(String term) async {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$term'),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['items'];

      if (responseData != null) {
        _searchResultsController.sink
            .add(List<Map<String, dynamic>>.from(responseData));
      } else {
        _searchResultsController.sink.addError("Kitap bulunamadı");
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
