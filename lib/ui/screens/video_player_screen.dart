import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/media_item.dart';
import '../../l10n/app_localizations.dart';

class VideoPlayerScreen extends StatefulWidget {
  final MediaItem mediaItem;
  final List<MediaItem>? playlist;

  const VideoPlayerScreen({super.key, required this.mediaItem, this.playlist});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late MediaItem _currentItem;
  int _currentIndex = 0;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.mediaItem;

    // Find current index in playlist
    if (widget.playlist != null) {
      _currentIndex = widget.playlist!.indexWhere(
        (item) => item.id == widget.mediaItem.id,
      );
      if (_currentIndex == -1) _currentIndex = 0;
    }

    _initializePlayer();
  }

  void _initializePlayer() {
    final videoId = _currentItem.mediaUrl ?? '';

    _controller =
        YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            enableCaption: true,
            controlsVisibleAtStart: true,
            hideControls: false,
          ),
        )..addListener(() {
          if (_isPlayerReady &&
              mounted &&
              _controller.value.playerState == PlayerState.ended) {
            _playNext();
          }
        });

    _isPlayerReady = true;
  }

  void _playNext() {
    if (widget.playlist != null &&
        _currentIndex < widget.playlist!.length - 1) {
      setState(() {
        _currentIndex++;
        _currentItem = widget.playlist![_currentIndex];
      });
      _controller.load(_currentItem.mediaUrl ?? '');
    }
  }

  void _playPrevious() {
    if (widget.playlist != null && _currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _currentItem = widget.playlist![_currentIndex];
      });
      _controller.load(_currentItem.mediaUrl ?? '');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context);

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: cs.primary,
        progressColors: ProgressBarColors(
          playedColor: cs.primary,
          handleColor: cs.primary,
          backgroundColor: cs.surfaceVariant,
          bufferedColor: cs.primaryContainer,
        ),
        onReady: () {
          setState(() {
            _isPlayerReady = true;
          });
        },
        topActions: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _currentItem.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              loc.t('media_video_title'),
              style: const TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              // Video Player
              player,

              // Video Info & Controls
              Expanded(
                child: Container(
                  color: cs.surface,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          _currentItem.title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),

                        // Subtitle
                        if (_currentItem.subtitle != null)
                          Text(
                            _currentItem.subtitle!,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: cs.onSurfaceVariant),
                          ),

                        const SizedBox(height: 24),

                        // Playlist Controls
                        if (widget.playlist != null &&
                            widget.playlist!.length > 1)
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Previous Button
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _currentIndex > 0
                                          ? _playPrevious
                                          : null,
                                      icon: const Icon(Icons.skip_previous),
                                      label: const Text('Previous'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Next Button
                                  Expanded(
                                    child: FilledButton.icon(
                                      onPressed:
                                          _currentIndex <
                                              widget.playlist!.length - 1
                                          ? _playNext
                                          : null,
                                      icon: const Icon(Icons.skip_next),
                                      label: const Text('Next'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        const SizedBox(height: 16),

                        // Playlist
                        if (widget.playlist != null &&
                            widget.playlist!.length > 1) ...[
                          Text(
                            'Playlist',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          ...List.generate(widget.playlist!.length, (index) {
                            final item = widget.playlist![index];
                            final isCurrentItem = index == _currentIndex;
                            return Card(
                              color: isCurrentItem
                                  ? cs.primaryContainer
                                  : cs.surfaceVariant,
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: Container(
                                  width: 60,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: cs.surface,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: item.thumbnailUrl.startsWith('http')
                                        ? Image.network(
                                            item.thumbnailUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.videocam,
                                                    color: cs.onSurfaceVariant,
                                                  );
                                                },
                                          )
                                        : Image.asset(
                                            item.thumbnailUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Icon(
                                                    Icons.videocam,
                                                    color: cs.onSurfaceVariant,
                                                  );
                                                },
                                          ),
                                  ),
                                ),
                                title: Text(
                                  item.title,
                                  style: TextStyle(
                                    fontWeight: isCurrentItem
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isCurrentItem
                                        ? cs.onPrimaryContainer
                                        : cs.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: item.subtitle != null
                                    ? Text(
                                        item.subtitle!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: isCurrentItem
                                              ? cs.onPrimaryContainer
                                                    .withOpacity(0.7)
                                              : cs.onSurfaceVariant.withOpacity(
                                                  0.7,
                                                ),
                                        ),
                                      )
                                    : null,
                                trailing: isCurrentItem
                                    ? Icon(
                                        Icons.play_circle_filled,
                                        color: cs.onPrimaryContainer,
                                      )
                                    : null,
                                onTap: () {
                                  if (!isCurrentItem) {
                                    setState(() {
                                      _currentIndex = index;
                                      _currentItem = item;
                                    });
                                    _controller.load(item.mediaUrl ?? '');
                                  }
                                },
                              ),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
