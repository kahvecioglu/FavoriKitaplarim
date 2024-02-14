import 'package:favorikitaplarim/models/book_models.dart';
import 'package:favorikitaplarim/models/provider_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final String? title;
  final String? authors;
  final String? publisher;
  final String? publishedDate;
  final String? pageCount;
  final String? thumbnail;

  const BookCard({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.pageCount,
    this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        Provider.of<ProviderBookModel>(context, listen: false).KitapSec(
            BookModel(
                title: title!,
                authors: authors!,
                pageCount: pageCount!,
                publishedDate: publishedDate!,
                publisher: publisher!,
                thumbnail: thumbnail!));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blue,
            content: Center(
              child: Text(
                "Favorilere Eklendi",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 23, 30, 37),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (thumbnail != null)
              Image.network(
                thumbnail!,
                width: 80,
                height: 110,
                fit: BoxFit.cover,
              )
            else
              Container(
                width: 80,
                height: 110,
                color: Colors.grey,
                child: Icon(Icons.image, color: Colors.white),
              ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    color: Colors.blue,
                  ),
                  Text(
                    'Yazarlar: $authors',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    'Yayıncı: $publisher',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Yayın Tarihi: $publishedDate',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(width: 30),
                      Text(
                        'Sayfa: $pageCount',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
