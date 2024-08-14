import 'package:trabajo_final/domain/entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> searchBooks(String query);
}
