import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readai/common/colors.dart';
import 'package:readai/widgets/search.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[100],
        title: const Text(
          "Читалка",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Поиск
            SearchField(),
            // Список книг
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Как завоевывать друзей и оказывать влияние на людей",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Дуайт Дэвид Эйзенхауэр (*18 сентября 1890 г. — "
                            "28 марта 1969 г.) — американский генерал и политик, "
                            "тридцать четвертый президент США (1953 по 1961 год)...\n"
                            "Глава X, Абзац X",
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 10),

                          // Кнопки действий
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                icon: Text(
                                  "Q&A",
                                  style: TextStyle(fontSize: 12),
                                ),
                                label: SvgPicture.asset(
                                  "assets/icons/help.svg",
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[300],
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                icon: const Text(
                                  "Содержание",
                                  style: TextStyle(fontSize: 12),
                                ),
                                label: SvgPicture.asset(
                                  "assets/icons/book_add.svg",
                                  width: 18,
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  "читать",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Кнопка добавления
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green[300],
        child: const Icon(Icons.add),
      ),

      // Нижняя навигация
    );
  }
}
