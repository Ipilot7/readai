import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin DialogMixin<T extends StatefulWidget> on State<T> {
  // ====== Common sheet scaffold ======
  Widget _sheetScaffold({
    required BuildContext context,
    required String title,
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = Theme.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withOpacity(0.15),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Center(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: padding ?? const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  // ====== BOOK DIALOG ======
  Future<void> showBookDialog({
    required String imageUrl,
    required String title,
    required String author,
    required String description,
    VoidCallback? onRead,
  }) {
    final theme = Theme.of(context);
    return showDialog(
      context: context,
      builder:
          (_) => Dialog(
            insetPadding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      height: 220,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    author,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(
                        0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.left,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB7FF63),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onRead?.call();
                      },
                      child: const Text("читать"),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  // ====== ADD WORD DIALOG ======
  Future<void> showAddWordDialog({
    required void Function(String term, String book, String definition) onAdd,
  }) {
    final term = TextEditingController();
    final book = TextEditingController();
    final def = TextEditingController();

    final inputDecoration =
        (String hint) => InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFF3F4F6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        );

    return showDialog(
      context: context,
      builder:
          (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Новое слово",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: term,
                    decoration: inputDecoration("Термин"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: book,
                    decoration: inputDecoration("Книга/Глава"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: def,
                    decoration: inputDecoration("Определение"),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB7FF63),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onAdd(
                          term.text.trim(),
                          book.text.trim(),
                          def.text.trim(),
                        );
                      },
                      child: const Text("Добавить слово"),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  // ====== DELETE CONFIRM DIALOG ======
  Future<void> showDeleteDialog({
    required String title,
    required VoidCallback onDelete,
    String message = "Вы действительно желаете удалить книгу?",
  }) {
    final theme = Theme.of(context);
    return showDialog(
      context: context,
      builder:
          (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.delete_outline, size: 56),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(message, textAlign: TextAlign.center),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B6B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onDelete();
                      },
                      child: const Text("Удалить"),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Отменить"),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  // ====== SEARCH DICTIONARY SHEET ======
  Future<void> showSearchDictionarySheet({
    required List<DictionaryItem> items,
    ValueChanged<String>? onQueryChanged,
  }) {
    final controller = TextEditingController();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return _sheetScaffold(
          context: ctx,
          title: "Искать",
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Словарь",
                  style: Theme.of(
                    ctx,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                onChanged: onQueryChanged,
                decoration: InputDecoration(
                  hintText: "Поиск по словарю",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xFFF3F4F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final it = items[i];
                    return _DictionaryCard(item: it);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ====== SHARE SHEET ======
  Future<void> showShareSheet({
    required String imageUrl,
    required String title,
    required String author,
    required String shareLink,
    void Function(String platform, String link)? onShareTap,
  }) {
    final platforms = <_SharePlatform>[
      _SharePlatform("Телеграм", Icons.send),
      _SharePlatform("ВКонтакте", Icons.people_alt_outlined),
      _SharePlatform("WhatsApp", Icons.message),
      _SharePlatform("Facebook", Icons.facebook),
      _SharePlatform("Ещё", Icons.more_horiz),
    ];

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return _sheetScaffold(
          context: ctx,
          title: "",
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with cover + title
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      height: 48,
                      width: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          author,
                          style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                            color: Theme.of(
                              ctx,
                            ).textTheme.bodySmall?.color?.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(
                height: 1,
                color: Theme.of(ctx).colorScheme.onSurface.withOpacity(0.1),
              ),
              const SizedBox(height: 12),
              // Platforms row
              SizedBox(
                height: 92,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: platforms.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (_, i) {
                    final p = platforms[i];
                    return Column(
                      children: [
                        InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () => onShareTap?.call(p.name, shareLink),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: const Color(0xFFF3F4F6),
                            child: Icon(
                              p.icon,
                              size: 28,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(p.name, style: Theme.of(ctx).textTheme.bodySmall),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Copy link button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F4F6),
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: shareLink));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ссылка скопирована")),
                      );
                    }
                  },
                  icon: const Icon(Icons.link),
                  label: const Text("Скопировать ссылку"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ====== Helper models/widgets ======

class DictionaryItem {
  final String title; // "Слово транскрипция"
  final List<String> senses; // ["1. Значение", "2. Значение"]
  final String origin; // "происхождение"

  const DictionaryItem({
    required this.title,
    this.senses = const [],
    this.origin = "",
  });
}

class _DictionaryCard extends StatelessWidget {
  const _DictionaryCard({required this.item});
  final DictionaryItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Ink(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(
          Theme.of(context).brightness == Brightness.dark ? 0.25 : 0.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).maybePop(item),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              ...item.senses.map(
                (s) => Text(s, style: theme.textTheme.bodySmall),
              ),
              if (item.origin.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  item.origin,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SharePlatform {
  final String name;
  final IconData icon;
  _SharePlatform(this.name, this.icon);
}
