import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/media_item.dart';
import '../../l10n/app_localizations.dart';

class AudioPlayerScreen extends StatefulWidget {
  final MediaItem mediaItem;
  final List<MediaItem>? playlist;

  const AudioPlayerScreen({super.key, required this.mediaItem, this.playlist});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  late MediaItem _currentItem;
  int _currentIndex = 0;

  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.mediaItem;
    _audioPlayer = AudioPlayer();

    // Find current index in playlist
    if (widget.playlist != null) {
      _currentIndex = widget.playlist!.indexWhere(
        (item) => item.id == widget.mediaItem.id,
      );
      if (_currentIndex == -1) _currentIndex = 0;
    }

    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    // Listen to player state
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });

    // Listen to duration
    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          _duration = duration;
        });
      }
    });

    // Listen to position
    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });

    // Listen to completion
    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        _playNext();
      }
    });

    // Play initial audio
    _playAudio(_currentItem.mediaUrl ?? '');
  }

  Future<void> _playAudio(String url) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error playing audio: $e')));
      }
    }
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.resume();
    }
  }

  void _playNext() {
    if (widget.playlist != null &&
        _currentIndex < widget.playlist!.length - 1) {
      setState(() {
        _currentIndex++;
        _currentItem = widget.playlist![_currentIndex];
      });
      _playAudio(_currentItem.mediaUrl ?? '');
    }
  }

  void _playPrevious() {
    if (widget.playlist != null && _currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _currentItem = widget.playlist![_currentIndex];
      });
      _playAudio(_currentItem.mediaUrl ?? '');
    }
  }

  void _seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(loc.t('media_audio_title')),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show options menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Album Art
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: cs.primary.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _currentItem.thumbnailUrl.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: _currentItem.thumbnailUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: cs.surfaceVariant,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: cs.primary,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: cs.surfaceVariant,
                            child: Icon(
                              Icons.music_note,
                              size: 80,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        )
                      : Image.asset(
                          _currentItem.thumbnailUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: cs.surfaceVariant,
                              child: Icon(
                                Icons.music_note,
                                size: 80,
                                color: cs.onSurfaceVariant,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Song Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  _currentItem.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  _currentItem.subtitle ?? 'Hadiya Heritage Music',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 16,
                    ),
                  ),
                  child: Slider(
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble() > 0
                        ? _duration.inSeconds.toDouble()
                        : 1.0,
                    onChanged: (value) {
                      _seekTo(Duration(seconds: value.toInt()));
                    },
                    activeColor: cs.primary,
                    inactiveColor: cs.surfaceVariant,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_position),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        _formatDuration(_duration),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous Button
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 40,
                  color: widget.playlist != null && _currentIndex > 0
                      ? cs.onSurface
                      : cs.onSurfaceVariant.withOpacity(0.3),
                  onPressed: widget.playlist != null && _currentIndex > 0
                      ? _playPrevious
                      : null,
                ),

                // Play/Pause Button
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [cs.primary, cs.primary.withOpacity(0.8)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: cs.primary.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 48,
                    color: cs.onPrimary,
                    onPressed: _togglePlayPause,
                  ),
                ),

                // Next Button
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 40,
                  color:
                      widget.playlist != null &&
                          _currentIndex < widget.playlist!.length - 1
                      ? cs.onSurface
                      : cs.onSurfaceVariant.withOpacity(0.3),
                  onPressed:
                      widget.playlist != null &&
                          _currentIndex < widget.playlist!.length - 1
                      ? _playNext
                      : null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
