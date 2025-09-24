import 'package:flutter/material.dart';

class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Поиск",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.star_border, color: Colors.purple),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 12),

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
                                icon: const Icon(Icons.question_answer),
                                label: const Text("Q&A"),
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
                                icon: const Icon(Icons.list),
                                label: const Text("Содержание"),
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
                                child: const Text("читать"),
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
