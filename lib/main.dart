// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_animate/flutter_animate.dart'; // Importa flutter_animate
import 'package:getwidget/getwidget.dart'; // Importa getwidget

import 'package:trabajo_final/infraestructure/datasources/book_remote_datasource.dart';
import 'package:trabajo_final/infraestructure/repositories/book_repository_impl.dart';
import 'package:trabajo_final/presentation/providers/book_search_provider.dart';
import 'package:trabajo_final/presentation/screens/search_page.dart';

void main() {
  final bookRemoteDataSource = BookRemoteDataSourceImpl(client: http.Client());
  final bookRepository = BookRepositoryImpl(remoteDataSource: bookRemoteDataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookSearchProvider(repository: bookRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Library Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Puedes personalizar el tema aquí según los widgets de getwidget
      ),
      home: const SearchPage(),
    );
  }
}
