import 'package:favorikitaplarim/models/book_models.dart';
import 'package:hive/hive.dart';

// Bu adaptör, TypeAdapter sınıfını genişleterek BookModel türündeki nesneleri ikili veriye dönüştürme ve ikili veriden BookModel nesneleri oluşturma yöntemidir.
class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0; // adaptörü için tanımlayıcı id

  @override
  BookModel read(BinaryReader reader) {
    //   BookModel nesnesi oluştur
    return BookModel(
      title: reader.readString(),
      authors: reader.readString(),
      pageCount: reader.readString(),
      publishedDate: reader.readString(),
      publisher: reader.readString(),
      thumbnail: reader.readString(),
      id: reader.readString(),
    );
  }

  // veriye nasıl yazacağını uygula
  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.authors);
    writer.writeString(obj.pageCount);
    writer.writeString(obj.publishedDate);
    writer.writeString(obj.publisher);
    writer.writeString(obj.thumbnail);
    writer.writeString(obj.id);
  }
}
