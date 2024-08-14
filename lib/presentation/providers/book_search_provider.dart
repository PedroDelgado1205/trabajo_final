import 'package:flutter/material.dart';
import 'package:trabajo_final/domain/entities/book.dart';
import 'package:trabajo_final/domain/repositories/book_repository.dart';

class BookSearchProvider with ChangeNotifier {
  final BookRepository repository;
  List<Book> _books = [];
  List<Book> get books => _books;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String _lastQuery = '';

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
        _books = results.take(25).toList();  // Limita los resultados a un máximo de 25 libros
      }
    } catch (error) {
      _error = 'Error durante la búsqueda: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
