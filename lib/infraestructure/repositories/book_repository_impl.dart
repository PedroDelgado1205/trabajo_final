import 'package:trabajo_final/domain/entities/book.dart';
import 'package:trabajo_final/domain/repositories/book_repository.dart';
import 'package:trabajo_final/infraestructure/datasources/book_remote_datasource.dart';
import 'package:trabajo_final/infraestructure/models/book_models.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Book>> searchBooks(String query) async {
    // Obtén los datos desde el remote data source
    final List<BookModel> results = await remoteDataSource.searchBooks(query);

    // Convierte cada BookModel a Book
    return results
        .map((bookModel) => Book(
              title: bookModel.title,
              authorName: bookModel.authorName,
              firstPublishYear: bookModel.firstPublishYear,
              isbn: bookModel.isbn,
              description: bookModel.description,
              location: bookModel.location,
              translatedFrom: bookModel.translatedFrom,
              contributor: bookModel.contributor,
              format: bookModel.format,
              numberofpagesmedian: bookModel.numberofpagesmedian?.toString(),
              openLibraryID: bookModel.openLibraryID,
              internetArchiveID: bookModel.internetArchiveID,
              lccn: bookModel.lccn,
              oclc: bookModel.oclc,
              coverUrl: bookModel.coverUrl,
              idAmazon: bookModel.idAmazon,
            ))
        .toList();
  }
}
