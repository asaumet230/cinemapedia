import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:cinemapedia/domain/entities/entities.dart';

import '../../providers/movies/videos_movie_provider.dart';

class VideosFromMovie extends ConsumerWidget {
  final int movieId;

  const VideosFromMovie({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesFromVideo = ref.watch(videosFromMovieProvider(movieId));

    return moviesFromVideo.when(
      data: (videos) => _VideosList(videos: videos),
      error: (_, __) =>
          const Center(child: Text('No se pudo cargar películas similares')),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _VideosList extends StatelessWidget {
  final List<Video> videos;

  const _VideosList({required this.videos});

  @override
  Widget build(BuildContext context) {
    final textStye = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    //* Nada que mostrar
    if (videos.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Icon(
            Icons.movie_creation_outlined,
            color: color.secondary,
            size: 50,
          ),
          SizedBox(
            child: Center(
              child: Text(
                'Lo Sentimos No hay Videos',
                style: textStye.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: color.secondary),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ignore: prefer_const_constructors
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            'Videos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        //* Aunque tengo varios videos, sólo quiero mostrar el primero
        _YouTubeVideoPlayer(
          youtubeId: videos.first.youtubeKey,
          name: videos.first.name,
        ),

        //* Si se desean mostrar todos los videos
        // ...videos.map(
        //   (video) => _YouTubeVideoPlayer(youtubeId: videos.first.youtubeKey, name: video.name)
        // ).toList()
        const SizedBox(height: 30),
      ],
    );
  }
}

class _YouTubeVideoPlayer extends StatefulWidget {
  final String youtubeId;
  final String name;

  const _YouTubeVideoPlayer({
    required this.youtubeId,
    required this.name,
  });

  @override
  State<_YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name),
          YoutubePlayer(controller: _controller),
        ],
      ),
    );
  }
}
