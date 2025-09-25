import 'package:flutter/material.dart';
import 'package:readai/common/colors.dart';
import 'package:readai/widgets/search.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final _tabs = ["Все", "Английский", "Французский", "Русский", "Немецкий"];
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        title: const Text(
          "Мой словарь",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Поиск
            SearchField(),
            // Табы
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  _tabs.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_tabs[index]),
                      selected: _selectedTab == index,
                      onSelected: (_) {
                        setState(() => _selectedTab = index);
                      },
                      selectedColor: Colors.green[300],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              "Термины",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),

            // Список терминов
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColors.white,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: const Text(
                        "Термин",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        "Книга Глава 3\nОпределение термина",
                      ),
                      trailing: OutlinedButton(
                        
                        onPressed: () {},
                        child: const Text("Подробнее"),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
