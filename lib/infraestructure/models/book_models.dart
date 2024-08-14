import 'package:trabajo_final/domain/entities/book.dart';

class BookModel {
  final String title;
  final List<String>? authorName;
  final int? firstPublishYear;
  final List<String>? isbn;
  final String? description;
  final String? location;
  final String? translatedFrom;
  final String? contributor;
  final String? format;
  final int? numberofpagesmedian;
  final String? openLibraryID;
  final String? internetArchiveID;
  final String? lccn;
  final String? oclc;
  final String? coverUrl;
  final List<String>? idAmazon;

  BookModel({
    required this.title,
    this.authorName,
    this.firstPublishYear,
    this.isbn,
    this.description,
    this.location,
    this.translatedFrom,
    this.contributor,
    this.format,
    this.numberofpagesmedian,
    this.openLibraryID,
    this.internetArchiveID,
    this.lccn,
    this.oclc,
    this.coverUrl,
    this.idAmazon,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] as String,
      authorName: (json['author_name'] as List<dynamic>?)
          ?.map((name) => name as String)
          .toList(),
      firstPublishYear: json['first_publish_year'] as int?,
      isbn: (json['isbn'] as List<dynamic>?)
          ?.map((isbn) => isbn as String)
          .toList(),
      description: json['description'] as String?,
      location: _extractFirstString(json['location']),
      translatedFrom: _extractFirstString(json['translated_from']),
      contributor: _extractFirstString(json['contributor']),
      format: _extractFirstString(json['format']),
      numberofpagesmedian: _extractInt(json['number_of_pages_median']),
      openLibraryID: _extractFirstString(json['open_library_id']),
      internetArchiveID: _extractFirstString(json['internet_archive_id']),
      lccn: _extractFirstString(json['lccn']),
      oclc: _extractFirstString(json['oclc']),
      coverUrl: _buildCoverUrl(json),
      idAmazon: (json['id_amazon'] as List<dynamic>?) 
          ?.map((link) => link as String)
          .toList(),
    );
  }

  static String? _extractFirstString(dynamic value) {
    if (value == null) return null;
    if (value is List<dynamic> && value.isNotEmpty) {
      return value.first is String ? value.first as String : null;
    }
    return value is String ? value : null;
  }

  static int? _extractInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      final parsed = int.tryParse(value);
      return parsed;
    }
    return null;
  }

  static String? _buildCoverUrl(Map<String, dynamic> json) {
    final coverEditionKey = json['cover_edition_key'] as String?;
    final coverId = json['cover_i'] as int?;

    if (coverEditionKey != null) {
      return 'https://covers.openlibrary.org/b/olid/$coverEditionKey-L.jpg';
    } else if (coverId != null) {
      return 'https://covers.openlibrary.org/b/id/$coverId-L.jpg';
    }
    return null;
  }

  // Implementación de `fromDomain`
  static BookModel fromDomain(Book book) {
    return BookModel(
      title: book.title,
      authorName: book.authorName,
      firstPublishYear: book.firstPublishYear,
      isbn: book.isbn,
      description: book.description,
      location: book.location,
      translatedFrom: book.translatedFrom,
      contributor: book.contributor,
      format: book.format,
      numberofpagesmedian: book.numberofpagesmedian != null
          ? int.tryParse(book.numberofpagesmedian!)
          : null,
      openLibraryID: book.openLibraryID,
      internetArchiveID: book.internetArchiveID,
      lccn: book.lccn,
      oclc: book.oclc,
      coverUrl: book.coverUrl,
      idAmazon: book.idAmazon
    );
  }
}
