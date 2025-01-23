import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Menu/MenuSide.dart';

class VideoMed extends StatefulWidget {
  const VideoMed({super.key});

  @override
  State<VideoMed> createState() => _VideoMedState();
}

class _VideoMedState extends State<VideoMed> {
  final List<String> videoUrls = [
    "https://www.youtube.com/watch?v=dmHveh1KT5c&list=PL1oM0oQ26NeADddj-6taI3T4N_aaGCKTJ&ab_channel=GroupeBaridAl-Maghrib",
    "https://youtu.be/Q7sRH_zH_HA",
    "https://youtu.be/Y3h3L-Jfrbo",
    "https://youtu.be/HZZhw6YIukg",
  ];

  late int _currentVideoIndex;
  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    _currentVideoIndex = 0;
    _controllers = List.generate(
      videoUrls.length,
      (index) => YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoUrls[index])!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      ),
    );
    super.initState();
  }

  void _playVideo(int index) {
    setState(() {
      _currentVideoIndex = index;
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appB(context),
      drawer: darweF(context),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey, // Placeholder color
                      ),
                      YoutubePlayer(
                        controller: _controllers[index],
                        showVideoProgressIndicator: true,
                        bottomActions: [
                          CurrentPosition(),
                          ProgressBar(
                            isExpanded: true,
                            colors: const ProgressBarColors(
                              playedColor: Color.fromARGB(255, 255, 72, 0),
                              handleColor: Colors.orangeAccent,
                            ),
                          ),
                          const PlaybackSpeedButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const NavBottom(),
    );
  }
}
