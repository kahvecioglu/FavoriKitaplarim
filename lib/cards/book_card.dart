import 'package:favorikitaplarim/models/book_models.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookCard extends StatelessWidget {
  final String? title;
  final String? authors;
  final String? publisher;
  final String? publishedDate;
  final String? pageCount;
  final String? thumbnail;
  final BookModel? book;
  Function()? onLongPress;
  Function()? onDoubleTap;
  final String? id;
  Color? bordercolor;
  final bool? isFavorite;

  BookCard(
      {this.title,
      this.authors,
      this.publisher,
      this.publishedDate,
      this.pageCount,
      this.thumbnail,
      this.book,
      this.onLongPress,
      this.onDoubleTap,
      this.id,
      this.bordercolor = Colors.blue,
      this.isFavorite});

  @override
  Widget build(BuildContext context) {
    Color bordercolor =
        isFavorite != null && isFavorite! ? Colors.green : Colors.blue;
    return InkWell(
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 23, 30, 37),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: bordercolor, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              thumbnail!,
              width: 80,
              height: 110,
              fit: BoxFit.cover,
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
