import 'dart:convert';

import 'package:favorikitaplarim/cards/book_card.dart';
import 'package:favorikitaplarim/screens/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  String _searchTerm = "";
  List<Map<String, dynamic>> _books = [];

  void _searchBooks(String term) async {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$term'),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['items'];

      if (responseData != null) {
        setState(() {
          _books = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        setState(() {
          _books.clear();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.blue,
              content: Text(
                "Kitap bulunamadı",
                style: TextStyle(fontSize: 20),
              )));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text("Kitaplar Yüklenirken Bir Sorun Oluştu..",
              style: TextStyle(fontSize: 20))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 30, 37),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 23, 30, 37),
        title: Text(
          "Favori Kitaplarım",
          style: TextStyle(color: Colors.white, fontSize: 33),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(),
                  ));
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.search, color: Colors.white, size: 30),
                      hintText: "Arama yapınız..",
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchTerm = value;

                        if (_searchTerm.isEmpty) {
                          _books.clear();
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: IconButton(
                      onPressed: () {
                        if (_searchTerm.length > 500) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text(
                                "Terim Çok Uzun",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          );
                        } else {
                          _searchBooks(_searchTerm);
                        }
                      },
                      icon: Text(
                        "ARAMA",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: _searchTerm.isEmpty
                ? Center(
                    child: Text(
                      "Arama Yapmak İçin Terim Girin",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  )
                : _books.isEmpty
                    ? Center(
                        child: Text("Kitap Bulunamadı"),
                      )
                    : ListView.builder(
                        itemCount: _books.length,
                        itemBuilder: (context, index) {
                          final book = _books[index];
                          final volumeInfo = book['volumeInfo'];
                          final title = volumeInfo['title'] ?? 'Bilgi yok';
                          final authors = volumeInfo['authors'] != null
                              ? volumeInfo['authors'].join(', ')
                              : 'Bilgi yok';
                          final publisher =
                              volumeInfo['publisher'] ?? 'Bilgi yok';
                          final publishedDate =
                              volumeInfo['publishedDate'] ?? 'Bilgi yok';
                          final pageCount =
                              volumeInfo['pageCount']?.toString() ??
                                  'Bilgi yok';
                          final thumbnail = volumeInfo['imageLinks'] != null
                              ? volumeInfo['imageLinks']['thumbnail']
                              : null;

                          return BookCard(
                            title: title,
                            authors: authors,
                            pageCount: pageCount,
                            publishedDate: publishedDate,
                            publisher: publisher,
                            thumbnail: thumbnail,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
