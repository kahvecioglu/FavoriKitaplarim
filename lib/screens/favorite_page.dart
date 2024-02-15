import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:favorikitaplarim/cards/book_card.dart';
import 'package:favorikitaplarim/models/book_models.dart';
import 'package:favorikitaplarim/models/provider_book_model.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 30, 37),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 23, 30, 37),
        centerTitle: true,
        title: const Text(
          'Favoriler',
          style: TextStyle(color: Colors.white, fontSize: 33),
        ),
      ),
      body: Consumer<ProviderBookModel>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.secilenkitaplar.length,
            itemBuilder: (context, index) {
              BookModel book = provider.secilenkitaplar[index];
              return BookCard(
                isFavorite: true,
                book: book,
                id: book.id,
                title: book.title,
                authors: book.authors,
                pageCount: book.pageCount,
                publishedDate: book.publishedDate,
                publisher: book.publisher,
                thumbnail: book.thumbnail,
                onLongPress: () {
                  if (Provider.of<ProviderBookModel>(context, listen: false)
                      .secilenkitaplar
                      .contains(book)) {
                    Provider.of<ProviderBookModel>(context, listen: false)
                        .bookRemove(book);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
