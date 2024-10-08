import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:getwidget/getwidget.dart';
import 'package:trabajo_final/infraestructure/models/book_models.dart';

class BookList extends StatelessWidget {
  final List<BookModel> books;
  final void Function(BookModel) onBookTap;

  const BookList({
    super.key,
    required this.books,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];

        return GFListTile(
          avatar: book.coverUrl != null
              ? GFAvatar(
                  backgroundImage: NetworkImage(book.coverUrl!),
                  radius: 30,
                )
              : const GFAvatar(
                  radius: 30,
                  child: Icon(Icons.book, size: 30),
                ),
          title: Text(
            book.title,
            style: theme.textTheme.bodyLarge,
          ),
          subTitle: Text(
            book.authorName?.join(", ") ?? "Autor desconocido",
            style: theme.textTheme.bodySmall,
          ),
          onTap: () {
            onBookTap(book);
          },
        ).animate().fadeIn(duration: 0.5.seconds);
      },
    );
  }
}
