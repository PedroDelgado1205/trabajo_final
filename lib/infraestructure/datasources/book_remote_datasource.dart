import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trabajo_final/infraestructure/models/book_models.dart';
import 'package:trabajo_final/shared/data/constants.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> searchBooks(String query);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;

  BookRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BookModel>> searchBooks(String query) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/search.json?q=$query&limit=25'),  // Limita a 25 resultados
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final books = (data['docs'] as List)
          .map((json) => BookModel.fromJson(json))
          .toList();
      
      return books;
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}
