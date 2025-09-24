

import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  ShelfTab _shelfTab = ShelfTab.added; // segmented in "Полки"

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top title + add button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    Text(
                      'Библиотека',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFCBFF9C),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('добавить книгу'),
                    ),
                  ],
                ),
              ),
            ),

            // Search + magic button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'по названиям, авторам, содержимому книг',
                          prefixIcon: const Icon(Icons.search),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Icon(Icons.auto_awesome),
                    ),
                  ],
                ),
              ),
            ),

            // Current book
            const SliverToBoxAdapter(child: _SectionTitle('Текущая книга')),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CurrentBookCard(
                  book: demoBooks.first,
                  progress: 0.5,
                  onContinue: () {},
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            const SliverToBoxAdapter(child: _SectionTitle('Полки')),

            // Segmented chips
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Wrap(
                  spacing: 8,
                  children:
                      ShelfTab.values.map((t) {
                        final bool selected = _shelfTab == t;
                        return ChoiceChip(
                          label: Text(t.label),
                          selected: selected,
                          onSelected: (_) => setState(() => _shelfTab = t),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          side: BorderSide(
                            color:
                                selected
                                    ? Colors.transparent
                                    : Colors.grey.shade300,
                          ),
                          selectedColor: const Color(0xFFCBFF9C),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),

            // Shelf list depending on tab
            SliverToBoxAdapter(
              child: SizedBox(
                height: 260,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: _booksForTab(_shelfTab).length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final b = _booksForTab(_shelfTab)[index];
                    return BookTile(book: b, width: 190);
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 92),
            ), // space for bottom bar
          ],
        ),
      ),
    );
  }

  List<Book> _booksForTab(ShelfTab tab) {
    switch (tab) {
      case ShelfTab.added:
        return demoBooks;
      case ShelfTab.opened:
        return demoBooks2;
      case ShelfTab.saved:
        return demoBooks3;
    }
  }
}

/* ---------------- UI bits ---------------- */

enum ShelfTab { added, opened, saved }

extension on ShelfTab {
  String get label {
    switch (this) {
      case ShelfTab.added:
        return 'Недавно добавленные';
      case ShelfTab.opened:
        return 'Недавно открытые';
      case ShelfTab.saved:
        return 'Закладки';
    }
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class CurrentBookCard extends StatelessWidget {
  const CurrentBookCard({
    super.key,
    required this.book,
    required this.progress,
    required this.onContinue,
  });
  final Book book;
  final double progress;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          BookCover(imageUrl: book.coverUrl, width: 90, height: 128),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'автор:\n${book.author}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('${(progress * 100).round()}%'),
                    const SizedBox(width: 4),
                    const Icon(Icons.change_circle_outlined, size: 18),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF9BFF6A),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: onContinue,
                    child: const Text('продолжить чтение'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookTile extends StatelessWidget {
  const BookTile({super.key, required this.book, this.onTap, this.width = 170});
  final Book book;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookCover(
              imageUrl: book.coverUrl,
              width: double.infinity,
              height: 160,
            ),
            const SizedBox(height: 8),
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });
  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder:
              (_, __, ___) => Container(
                color: const Color(0xFFEFEFEF),
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported),
              ),
        ),
      ),
    );
  }
}

/* ------------- Demo data ------------- */

class Book {
  final String title;
  final String author;
  final String coverUrl;
  const Book({
    required this.title,
    required this.author,
    required this.coverUrl,
  });
}

const demoBooks = [
  Book(
    title: 'Понедельник начинается в субботу',
    author: 'Аркадий и Борис Стругацкие',
    coverUrl:
        'https://images.unsplash.com/photo-1544937950-fa07a98d237f?q=80&w=400',
  ),
  Book(
    title: 'Элизиум',
    author: 'А. Ривера',
    coverUrl:
        'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=400',
  ),
  Book(
    title: 'Грибы',
    author: 'Кто-то умный',
    coverUrl:
        'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?q=80&w=400',
  ),
];

const demoBooks2 = [
  Book(
    title: 'The Beatles: Осколки неба',
    author: 'Булгинин, Сидоров',
    coverUrl:
        'https://images.unsplash.com/photo-1512820790803-83ca734da794?q=80&w=400',
  ),
  Book(
    title: 'Cardboard Cowboys',
    author: 'Brian Conaghan',
    coverUrl:
        'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?q=80&w=400',
  ),
  Book(
    title: 'С тонким интеллектом',
    author: 'Бритни Смит',
    coverUrl:
        'https://images.unsplash.com/photo-1471107340929-a87cd0f5b5f3?q=80&w=400',
  ),
];

const demoBooks3 = [
  Book(
    title: 'Как справиться с тревогой',
    author: 'Гед, Джесеник-Омар',
    coverUrl:
        'https://images.unsplash.com/photo-1532012197267-da84d127e765?q=80&w=400',
  ),
  Book(
    title: 'Основные практики арт-терапии',
    author: 'Лиля Гузман',
    coverUrl:
        'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?q=80&w=400',
  ),
  Book(
    title: 'Секреты мышц',
    author: 'Джон и Ширин',
    coverUrl:
        'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=400',
  ),
];
