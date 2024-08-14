class Book {
  final String title;
  final List<String>? authorName;
  final int? firstPublishYear;
  final List<String>? isbn;
  final String? description;
  final String? location;
  final String? translatedFrom;
  final String? contributor;
  final String? format;
  final String? numberofpagesmedian;
  final String? openLibraryID;
  final String? internetArchiveID;
  final String? lccn;
  final String? oclc;
  final String? coverUrl;
  final List<String>? idAmazon;

  Book(
    {required this.title, 
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
    this.idAmazon,}
  );
}