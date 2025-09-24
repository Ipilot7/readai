import 'package:flutter/material.dart';
import 'package:readai/main_page.dart';

void main() => runApp(const LibraryApp());

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Библиотека',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF9BFF6A),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
          titleMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      home: const MainPage(),
      // home: const LibraryScreen(),
      // home: const DictionaryPage(),
      // home: const ReaderPage(),
      // home: const FavoritesPage(),
      // home: const ProfilePage(),
    );
  }
}
