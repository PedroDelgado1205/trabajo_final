// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa servicios para copiar al portapapeles
import 'package:flutter_animate/flutter_animate.dart'; // Importa flutter_animate
import 'package:getwidget/getwidget.dart'; // Importa getwidget
import 'package:trabajo_final/infraestructure/models/book_models.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa url_launcher

class BookDetailScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailScreen({super.key, required this.book});

  Future<void> _launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    // ignore: avoid_print
    print('Intentando abrir la URL: $uri');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showUrlDialog(url, context); // Muestra el diálogo si no se puede abrir la URL
      // ignore: avoid_print
      print('No se pudo abrir la URL: $url');
    }
  }

  void _showUrlDialog(String url, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('URL no disponible'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(url),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: url));
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('URL copiada al portapapeles')),
                  );
                },
                child: const Text('Copiar URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.coverUrl != null)
              GFImageOverlay(
                image: NetworkImage(book.coverUrl!),
                height: 200,
                boxFit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.darken,
                ),
              ).animate().fadeIn(duration: 1.seconds)
            else
              const Icon(Icons.book, size: 200)
                  .animate()
                  .fadeIn(duration: 1.seconds),
            const SizedBox(height: 16),
            Text(
              book.title,
              style: Theme.of(context).textTheme.titleLarge,
            ).animate().fadeIn(duration: 1.seconds),
            const SizedBox(height: 8),
            if (book.authorName != null)
              Text(
                'Autor${book.authorName!.length > 1 ? 'es' : ''}: ${book.authorName!.join(', ')}',
                style: Theme.of(context).textTheme.titleSmall,
              ).animate().fadeIn(duration: 1.seconds),
            if (book.firstPublishYear != null)
              Text(
                'Publicado en ${book.firstPublishYear}',
                style: Theme.of(context).textTheme.bodyMedium,
              ).animate().fadeIn(duration: 1.seconds),
            if (book.numberofpagesmedian != null)
              Text(
                'Número de páginas: ${book.numberofpagesmedian}',
                style: Theme.of(context).textTheme.bodyMedium,
              ).animate().fadeIn(duration: 1.seconds),
            if (book.description != null)
              Text(
                book.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ).animate().fadeIn(duration: 1.seconds),
            if (book.idAmazon != null && book.idAmazon!.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  final amazonId = book.idAmazon!.first;
                  final amazonUrl = 'https://www.amazon.com/s?k=$amazonId';
                  _launchURL(amazonUrl, context);
                },
                child: const Text('Obten el libro'),
              ).animate().fadeIn(duration: 1.seconds),
          ],
        ),
      ),
    );
  }
}
