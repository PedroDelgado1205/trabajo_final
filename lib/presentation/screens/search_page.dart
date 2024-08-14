import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_final/presentation/providers/book_search_provider.dart';
import 'package:trabajo_final/presentation/widgets/shared/book_list.dart';
import 'package:trabajo_final/presentation/screens/book_detail_screen.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookSearchProvider>(context);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Open Library', style: theme.textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                provider.searchBooks(value);
              },
              decoration: InputDecoration(
                hintText: 'Buscar libros...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (provider.error != null)
              Center(
                child: Text(
                  provider.error!,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            if (provider.books.isEmpty && !provider.isLoading && provider.error == null)
              Center(
                child: Text(
                  'No se encontraron resultados',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            if (provider.books.isNotEmpty && !provider.isLoading)
              Expanded(
                child: BookList(
                  books: provider.convertBooksToBookModels(provider.books),
                  onBookTap: (book) {
                    // Agrega el libro a los libros recientes
                    provider.addToRecentBooks(book);

                    // Navega a la pantalla de detalles del libro
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            if (provider.recentBooks.isNotEmpty) ...[
              Text('Últimos libros buscados:', style: Theme.of(context).textTheme.titleMedium),
              Expanded(
                child: BookList(
                  books: provider.recentBooks,
                  onBookTap: (book) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
