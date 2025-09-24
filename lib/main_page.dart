import 'package:flutter/material.dart';
import 'package:readai/favorite.dart';
import 'package:readai/library.dart';
import 'package:readai/main.dart';
import 'package:readai/profile.dart';
import 'package:readai/reader.dart';
import 'package:readai/slovar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _controller = PageController();
  int _index = 0;

  final items = const [
    _NavItem(Icons.menu_book, 'Моя библиотека'),
    _NavItem(Icons.chrome_reader_mode, 'Читалка'),
    _NavItem(Icons.translate, 'Словарь'),
    _NavItem(Icons.bookmark, 'Избранное'),
    _NavItem(Icons.person, 'Профиль'),
  ];

  void _onTap(int i) {
    setState(() => _index = i);
    _controller.animateToPage(
      i,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (i) => setState(() => _index = i),
        children: const [
          LibraryScreen(),
          ReaderPage(),
          DictionaryPage(),
          FavoritesPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = constraints.maxWidth / items.length;

              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Зелёный движущийся фон
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    left: itemWidth * _index + 6,
                    top: 8,
                    height: 44,
                    width: _index == 0 ? 140 : 100, // у первой кнопки длиннее
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF9BFF6A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  // Кнопки поверх
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(items.length, (i) {
                      final selected = i == _index;
                      return GestureDetector(
                        onTap: () => _onTap(i),
                        child: SizedBox(
                          width: itemWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                items[i].icon,
                                size: 20,
                                color: Colors.black,
                              ),
                              if (selected) ...[
                                const SizedBox(width: 6),
                                Text(
                                  items[i].label,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
