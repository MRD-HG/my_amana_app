import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoMed extends StatefulWidget {
  const VideoMed({super.key});

  @override
  State<VideoMed> createState() => _VideoMedState();
}

class _VideoMedState extends State<VideoMed> {
  final List<Map<String, String>> _videos = const [
    {
      'title': 'Campagne My Amana',
      'url': 'https://www.youtube.com/watch?v=dmHveh1KT5c',
    },
    {
      'title': 'Amana – Services & Solutions',
      'url': 'https://www.youtube.com/watch?v=0oQ26NeADdd',
    },
    {
      'title': 'Barid Al-Maghrib – Official Channel',
      'url': 'https://www.youtube.com/@GroupeBaridAlMaghrib',
    },
  ];

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open the link on this device.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Reuse the existing app drawer from MenuSide.dart
      drawer: darweF(context),
      appBar: AppBar(
        title: const Text('Media'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _videos.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final v = _videos[i];
          final title = v['title'] ?? 'Video';
          final url = v['url'] ?? '';
          return Card(
            child: ListTile(
              leading: const Icon(Icons.play_circle_outline),
              title: Text(title),
              subtitle: Text(url, maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => _open(url),
            ),
          );
        },
      ),
    );
  }
}
