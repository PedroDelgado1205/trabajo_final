import 'package:flutter/material.dart';
import 'package:trabajo_final/domain/entities/book.dart';
import 'package:trabajo_final/domain/repositories/book_repository.dart';
import 'package:trabajo_final/infraestructure/models/book_models.dart';

class BookSearchProvider with ChangeNotifier {
  final BookRepository repository;
  List<Book> _books = [];
  List<Book> get books => _books;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String _lastQuery = '';

  final List<BookModel> _recentBooks = [];
  List<BookModel> get recentBooks => List.unmodifiable(_recentBooks);

  BookSearchProvider({required this.repository});

  Future<void> searchBooks(String query) async {
    if (query == _lastQuery) return;
    _lastQuery = query;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (query.isEmpty) {
        _books = [];
      } else {
        final results = await repository.searchBooks(query);
        _books = results.take(25).toList();
      }
    } catch (error) {
      _error = 'Error durante la búsqueda: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<BookModel> convertBooksToBookModels(List<Book> books) {
    return books.map((book) => BookModel.fromDomain(book)).toList();
  }

  void addToRecentBooks(BookModel book) {
    if (!_recentBooks.contains(book)) {
      _recentBooks.insert(0, book);
      if (_recentBooks.length > 10) {
        _recentBooks.removeLast();
      }
      notifyListeners();
    }
  }
}
