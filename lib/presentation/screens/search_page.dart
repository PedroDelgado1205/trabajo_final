import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Importa flutter_animate
import 'package:getwidget/getwidget.dart'; // Importa getwidget
import 'package:provider/provider.dart';
import 'package:trabajo_final/domain/entities/book.dart';
import 'package:trabajo_final/infraestructure/models/book_models.dart';
import 'package:trabajo_final/presentation/providers/book_search_provider.dart';
import 'package:trabajo_final/presentation/widgets/shared/book_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookSearchProvider>(context);

    List<BookModel> convertBooksToBookModels(List<Book> books) {
      return books.map((book) {
        return BookModel.fromDomain(book);
      }).toList();
    }

    return Scaffold(
      appBar: GFAppBar(
        title: const Text('Open Library'),
        // Usando GFAppBar de getwidget
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GFTextField(
              onChanged: (value) {
                provider.searchBooks(value);
              },
              decoration: InputDecoration(
                hintText: 'Buscar libros...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // Usando GFTextField de getwidget para un diseño más atractivo
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
                  .animate().fadeIn(duration: 0.5.seconds), // Animación de desvanecimiento para el indicador de carga
            if (provider.error != null)
              Center(child: Text(provider.error!))
                  .animate().fadeIn(duration: 0.5.seconds), // Animación de desvanecimiento para el mensaje de error
            if (provider.books.isEmpty && !provider.isLoading && provider.error == null)
              const Center(child: Text('No se encontraron resultados'))
                  .animate().fadeIn(duration: 0.5.seconds), // Animación de desvanecimiento para el mensaje de no resultados
            if (provider.books.isNotEmpty && !provider.isLoading)
              Expanded(child: BookList(books: convertBooksToBookModels(provider.books))),
          ],
        ),
      ),
    );
  }
}
