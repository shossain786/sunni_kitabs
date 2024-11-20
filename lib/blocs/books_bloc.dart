import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';

class BooksBloc extends Cubit<List<Book>> {
  BooksBloc() : super([]);

  Future<void> fetchBooks(String category) async {
    final response = await http.get(
      Uri.parse('http://yourserver.com/get_books_by_category.php?category=$category'),
    );

    if (response.statusCode == 200) {
      final List books = jsonDecode(response.body);
      emit(books.map((book) => Book.fromJson(book)).toList());
    }
  }
}
