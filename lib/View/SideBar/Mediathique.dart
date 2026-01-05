import 'package:flutter/material.dart';
import 'package:my_amana_app/View/Menu/MenuSide.dart';
import 'package:my_amana_app/core/theme/app_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoMed extends StatefulWidget {
  const VideoMed({super.key});

  @override
  State<VideoMed> createState() => _VideoMedState();
}

class _VideoMedState extends State<VideoMed> {
  final List<Map<String, String>> _videos = const [
    {
      'title': 'Campagne My Amana',
      'url':
          'https://www.youtube.com/watch?v=dmHveh1KT5c&list=PL1oM0oQ26NeADddj-6taI3T4N_aaGCKTJ&ab_channel=GroupeBaridAl-Maghrib',
    },
    {
      'title': 'Livraison express',
      'url': 'https://youtu.be/Q7sRH_zH_HA',
    },
    {
      'title': 'Solutions e-commerce',
      'url': 'https://youtu.be/Y3h3L-Jfrbo',
    },
    {
      'title': 'Service client',
      'url': 'https://youtu.be/HZZhw6YIukg',
    },
  ];

  late final List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = _videos
        .map(
          (video) => YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(video['url']!)!,
            flags: const YoutubePlayerFlags(autoPlay: false),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.hero,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mediatheque',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Videos et actualites Barid Al Maghrib.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          for (int i = 0; i < _videos.length; i++)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _videos[i]['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: YoutubePlayer(
                          controller: _controllers[i],
                          showVideoProgressIndicator: true,
                          bottomActions: [
                            CurrentPosition(),
                            ProgressBar(
                              isExpanded: true,
                              colors: const ProgressBarColors(
                                playedColor: AppColors.primary,
                                handleColor: AppColors.primaryDark,
                              ),
                            ),
                            const PlaybackSpeedButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
