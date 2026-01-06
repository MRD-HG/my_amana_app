import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/View/resultat.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:my_amana_app/features/my_trackings/models/saved_tracking.dart';
import 'package:my_amana_app/features/my_trackings/my_trackings_store.dart';

class MyTrackingsPage extends StatefulWidget {
  const MyTrackingsPage({super.key});

  @override
  State<MyTrackingsPage> createState() => _MyTrackingsPageState();
}

class _MyTrackingsPageState extends State<MyTrackingsPage> {
  late final Future<MyTrackingsStore> _storeFuture;
  late Future<List<SavedTracking>> _listFuture;

  @override
  void initState() {
    super.initState();
    _storeFuture = MyTrackingsStore.create();
    _listFuture = _load();
  }

  Future<List<SavedTracking>> _load() async {
    final store = await _storeFuture;
    return store.loadAll();
  }

  Future<void> _refresh() async {
    setState(() => _listFuture = _load());
    await _listFuture;
  }

  Future<void> _rename(MyTrackingsStore store, SavedTracking item) async {
    final controller = TextEditingController(text: item.label);
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Rename'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Label'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Save')),
        ],
      ),
    );
    if (result == null) return;
    await store.rename(item.id, result);
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<MyTrackingsStore>(
          future: _storeFuture,
          builder: (context, storeSnap) {
            if (!storeSnap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final store = storeSnap.data!;
            return FutureBuilder<List<SavedTracking>>(
              future: _listFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final items = snapshot.data ?? [];
                if (items.isEmpty) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text('No history yet.', style: TextStyle(color: AppColors.mutedText)),
                    ],
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () async {
                            await store.toggleFavorite(item.id);
                            await _refresh();
                          },
                          icon: Icon(
                            item.isFavorite ? Icons.star : Icons.star_border,
                            color: item.isFavorite ? AppColors.primary : AppColors.mutedText,
                          ),
                        ),
                        title: Text(item.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(item.id, style: TextStyle(color: AppColors.mutedText)),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'rename') {
                              await _rename(store, item);
                            } else if (value == 'delete') {
                              await store.delete(item.id);
                              await _refresh();
                            }
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: 'rename', child: Text('Rename')),
                            PopupMenuItem(value: 'delete', child: Text('Delete')),
                          ],
                        ),
                        onTap: () async {
                          await store.saveViewed(item.id);
                          if (!mounted) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Resultat(trackingId: item.id)),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
