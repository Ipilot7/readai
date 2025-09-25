import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readai/common/colors.dart';
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
    _NavItem("assets/icons/base.svg", 'Моя библиотека'),
    _NavItem("assets/icons/document.svg", 'Читалка'),
    _NavItem("assets/icons/t.svg", 'Словарь'),
    _NavItem("assets/icons/save.svg", 'Избранное'),
    _NavItem("assets/icons/person.svg", 'Профиль'),
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
      backgroundColor: AppColors.grey,
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
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = i == _index;
              return GestureDetector(
                onTap: () => _onTap(i),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(
                    horizontal: i == _index ? 16 : 5,
                  ),
                  decoration: BoxDecoration(
                    color: i == _index ? AppColors.green : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        items[i].icon,
                        width: 20,
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
        ),
      ),
    );
  }
}

class _NavItem {
  final String icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
