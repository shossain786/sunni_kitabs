import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/books_bloc.dart';
import '../models/book.dart';
import 'book_webview_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> categories = ["Fiction", "Science", "History"];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Books")),
      body: Column(
        children: [
          DropdownButton<String>(
            items: categories
                .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                .toList(),
            onChanged: (category) {
              context.read<BooksBloc>().fetchBooks(category!);
            },
          ),
          Expanded(
            child: BlocBuilder<BooksBloc, List<Book>>(
              builder: (context, books) {
                if (books.isEmpty) {
                  return const Center(child: Text("No Books Available"));
                }
                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return ListTile(
                      title: Text(book.name),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BookWebViewScreen(
                                      book.link,
                                      bookUrl: '',
                                    )));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
