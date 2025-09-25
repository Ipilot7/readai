import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readai/common/colors.dart';
import 'package:readai/widgets/search.dart';

enum FavSort { date, chapter, pinned }

class FavoriteItem {
  FavoriteItem({
    required this.title,
    required this.snippet,
    required this.chapter,
    required this.paragraph,
    required this.createdAt,
    this.pinned = false,
  });

  String get chapterDisplay => "Глава $chapter, Абзац $paragraph";

  final String title;
  final String snippet;
  final int chapter;
  final int paragraph;
  final DateTime createdAt;
  bool pinned;
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _searchCtrl = TextEditingController();
  FavSort _sort = FavSort.date;

  final List<FavoriteItem> _all = List.generate(
    8,
    (i) => FavoriteItem(
      title: "Название",
      snippet:
          "Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст Текст",
      chapter: (i % 5) + 1,
      paragraph: (i % 3) + 1,
      createdAt: DateTime.now().subtract(Duration(days: i * 2)),
      pinned: i % 4 == 0,
    ),
  );

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<FavoriteItem> _filtered() {
    final q = _searchCtrl.text.trim().toLowerCase();
    Iterable<FavoriteItem> items = _all;

    if (q.isNotEmpty) {
      items = items.where(
        (e) =>
            e.title.toLowerCase().contains(q) ||
            e.snippet.toLowerCase().contains(q) ||
            e.chapterDisplay.toLowerCase().contains(q),
      );
    }

    switch (_sort) {
      case FavSort.date:
        items =
            items.toList()
              ..toList().sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case FavSort.chapter:
        items =
            items.toList()
              ..toList().sort((a, b) {
                final byChapter = a.chapter.compareTo(b.chapter);
                return byChapter != 0
                    ? byChapter
                    : a.paragraph.compareTo(b.paragraph);
              });
        break;
      case FavSort.pinned:
        items = items.where((e) => e.pinned);
        break;
    }

    // Хотим, чтобы закреплённые всегда сверху при обычных режимах
    if (_sort != FavSort.pinned) {
      final list = items.toList();
      list.sort((a, b) {
        if (a.pinned == b.pinned) return 0;
        return a.pinned ? -1 : 1;
      });
      return list;
    }
    return items.toList();
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.grey[100];
    final green = const Color(0xFFAEEA63); // мягкий салатовый как в макете

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg,

        title: Text(
          """Избранное-
Название книги""",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SearchField(),
            Row(
              children: [
                _SortChip(
                  label: "По дате",
                  selected: _sort == FavSort.date,
                  onTap: () => setState(() => _sort = FavSort.date),
                ),
                const SizedBox(width: 8),
                _SortChip(
                  label: "По главе",
                  selected: _sort == FavSort.chapter,
                  onTap: () => setState(() => _sort = FavSort.chapter),
                ),
                const SizedBox(width: 8),
                _SortChip(
                  label: "Закреплённые",
                  selected: _sort == FavSort.pinned,
                  onTap: () => setState(() => _sort = FavSort.pinned),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Список
            Expanded(
              child: ListView.builder(
                itemCount: _filtered().length,
                itemBuilder: (context, i) {
                  final item = _filtered()[i];
                  return _FavCard(
                    item: item,
                    green: green,
                    onShare: () {
                      // Здесь подключай share_plus, если надо. Пока просто тост.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Поделиться: ещё не подключено"),
                        ),
                      );
                    },
                    onDelete: () {
                      setState(() => _all.remove(item));
                    },
                    onPin: () {
                      setState(() => item.pinned = !item.pinned);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  const _SortChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: Colors.black,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class _FavCard extends StatelessWidget {
  const _FavCard({
    required this.item,
    required this.green,
    required this.onShare,
    required this.onDelete,
    required this.onPin,
  });

  final FavoriteItem item;
  final Color green;
  final VoidCallback onShare;
  final VoidCallback onDelete;
  final VoidCallback onPin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.snippet,
                  style: const TextStyle(fontSize: 13, height: 1.25),
                ),
                const SizedBox(height: 6),
                Text(
                  item.chapterDisplay,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        Row(
          children: [
            _pillButton(
              context,
              label: "Поделиться",
              icon: "assets/icons/upload.svg",
              bg: green,
              onTap: onShare,
            ),
            const SizedBox(width: 4),
            _pillButton(
              context,
              label: "Удалить",
              icon: "assets/icons/trash.svg",
              bg: green,
              onTap: onDelete,
            ),
            const SizedBox(width: 4),
            _pillButton(
              context,
              label: item.pinned ? "Открепить" : "Закрепить",
              icon: "assets/icons/star.svg",
              bg: green,
              onTap: onPin,
            ),
          ],
        ),
      ],
    );
  }

  Widget _pillButton(
    BuildContext context, {
    required String label,
    required String icon,
    required Color bg,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon),
                const SizedBox(width: 2),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
