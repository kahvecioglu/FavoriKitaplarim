import 'package:favorikitaplarim/bloc/bloc_search.dart';
import 'package:favorikitaplarim/cards/book_card.dart';
import 'package:favorikitaplarim/models/book_models.dart';
import 'package:favorikitaplarim/models/provider_book_model.dart';
import 'package:favorikitaplarim/screens/favorite_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = "";
  SearchBloc _searchBloc = SearchBloc();

  @override
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 30, 37),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 23, 30, 37),
        title: const Text(
          "Favori Kitaplarım",
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
          ),
          Consumer<ProviderBookModel>(
            builder: (context, value, child) {
              int favoriteCount = value.secilenkitaplar.length;
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  favoriteCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            },
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
                  child: Container(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchTerm = value;

                          if (value.isEmpty) {
                            _searchBloc.clearSearchResults();
                          }
                        });
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search,
                            color: Colors.white, size: 30),
                        hintText: "Arama yapınız..",
                        hintStyle: const TextStyle(
                            color: Colors.white, height: 0, fontSize: 18),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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
                      _searchTerm = _searchController.text;
                      if (_searchTerm.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.blue,
                            content: Center(
                              child: Text(
                                "Lütfen Bir Terim Girin",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        );
                      } else if (_searchTerm.length > 500) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.blue,
                            content: Center(
                              child: Text(
                                "Terim Çok Uzun",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        );
                      } else {
                        _searchBloc.searchBooks(_searchTerm, context);
                      }
                    },
                    icon: const Text(
                      "ARA",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _searchBloc.searchResults,
              builder: (context, snapshot) {
                if (_searchTerm.isEmpty) {
                  return const Center(
                    child: Text(
                      "Lütfen Bir Terim Giriniz",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  final books = snapshot.data!;
                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      final volumeInfo = book['volumeInfo'];
                      final title = volumeInfo['title'] ?? 'Bilgi yok';
                      final authors = volumeInfo['authors'] != null
                          ? volumeInfo['authors'].join(', ')
                          : 'Bilgi yok';
                      final publisher = volumeInfo['publisher'] ?? 'Bilgi yok';
                      final publishedDate =
                          volumeInfo['publishedDate'] ?? 'Bilgi yok';
                      final pageCount =
                          volumeInfo['pageCount']?.toString() ?? 'Bilgi yok';
                      final id = book['id'];
                      final thumbnail = volumeInfo['imageLinks'] != null
                          ? volumeInfo['imageLinks']['thumbnail']
                          : 'https://www.creativefabrica.com/wp-content/uploads/2021/04/05/Photo-Image-Icon-Graphics-10388619-1-1-580x386.jpg';
                      final isFavorite = Provider.of<ProviderBookModel>(context)
                          .secilenkitaplar
                          .any((element) => element.id == id);

                      return BookCard(
                        isFavorite: isFavorite,
                        onLongPress: () {
                          BookModel bookModel = BookModel(
                            id: id,
                            title: title,
                            authors: authors,
                            pageCount: pageCount,
                            publishedDate: publishedDate,
                            publisher: publisher,
                            thumbnail: thumbnail ??
                                'https://www.creativefabrica.com/wp-content/uploads/2021/04/05/Photo-Image-Icon-Graphics-10388619-1-1-580x386.jpg',
                          );

                          if (Provider.of<ProviderBookModel>(context,
                                  listen: false)
                              .secilenkitaplar
                              .any((element) => element.id == bookModel.id)) {
                            Provider.of<ProviderBookModel>(context,
                                    listen: false)
                                .bookRemove(bookModel);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.blue,
                              content: Center(
                                child: Text(
                                  "Favorilerden Kaldırıldı",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.blue,
                              content: Center(
                                child: Text(
                                  "Bu Kitap Favorilerde Mevcut Değil",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ));
                          }
                        },
                        onDoubleTap: () {
                          BookModel bookModel = BookModel(
                            id: id,
                            title: title,
                            authors: authors,
                            pageCount: pageCount,
                            publishedDate: publishedDate,
                            publisher: publisher,
                            thumbnail: thumbnail ??
                                "https://www.creativefabrica.com/wp-content/uploads/2021/04/05/Photo-Image-Icon-Graphics-10388619-1-1-580x386.jpg",
                          );
                          if (Provider.of<ProviderBookModel>(context,
                                  listen: false)
                              .secilenkitaplar
                              .any((element) => element.id == bookModel.id)) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.blue,
                              content: Center(
                                child: Text(
                                  "Bu Kitap Favorilerde Mevcut",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ));
                          } else {
                            Provider.of<ProviderBookModel>(context,
                                    listen: false)
                                .bookAdd(bookModel);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.blue,
                                content: Center(
                                  child: Text(
                                    "Favorilere Eklendi",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        title: title,
                        authors: authors,
                        pageCount: pageCount,
                        publishedDate: publishedDate,
                        publisher: publisher,
                        thumbnail: thumbnail,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Lütfen Bir Terim Giriniz",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
