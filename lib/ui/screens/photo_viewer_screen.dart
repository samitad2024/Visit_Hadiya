import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/media_item.dart';
import '../../l10n/app_localizations.dart';

class PhotoViewerScreen extends StatefulWidget {
  final MediaItem mediaItem;
  final List<MediaItem>? gallery;

  const PhotoViewerScreen({super.key, required this.mediaItem, this.gallery});

  @override
  State<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();

    // Find current index in gallery
    if (widget.gallery != null) {
      _currentIndex = widget.gallery!.indexWhere(
        (item) => item.id == widget.mediaItem.id,
      );
      if (_currentIndex == -1) _currentIndex = 0;
    } else {
      _currentIndex = 0;
    }

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  MediaItem get _currentItem {
    if (widget.gallery != null) {
      return widget.gallery![_currentIndex];
    }
    return widget.mediaItem;
  }

  void _sharePhoto() {
    Share.share(
      'Check out this photo: ${_currentItem.title}\n${_currentItem.subtitle ?? ""}',
      subject: _currentItem.title,
    );
  }

  void _toggleAppBar() {
    setState(() {
      _showAppBar = !_showAppBar;
    });
  }

  Widget _buildPhotoView(MediaItem item) {
    final imageUrl = item.mediaUrl ?? item.thumbnailUrl;

    if (imageUrl.startsWith('http')) {
      return PhotoView(
        imageProvider: CachedNetworkImageProvider(imageUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
        initialScale: PhotoViewComputedScale.contained,
        heroAttributes: PhotoViewHeroAttributes(tag: item.id),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(
            value: event == null
                ? null
                : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
          ),
        ),
        errorBuilder: (context, error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 48),
              const SizedBox(height: 16),
              Text(
                'Failed to load image',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        onTapUp: (context, details, controllerValue) => _toggleAppBar(),
      );
    } else {
      return PhotoView(
        imageProvider: AssetImage(imageUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 3,
        initialScale: PhotoViewComputedScale.contained,
        heroAttributes: PhotoViewHeroAttributes(tag: item.id),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        errorBuilder: (context, error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 48),
              const SizedBox(height: 16),
              Text(
                'Failed to load image',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        onTapUp: (context, details, controllerValue) => _toggleAppBar(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: _showAppBar
          ? AppBar(
              backgroundColor: Colors.black.withOpacity(0.5),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                loc.t('media_photos_title'),
                style: const TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: _sharePhoto,
                ),
              ],
            )
          : null,
      body: Stack(
        children: [
          // Photo Gallery
          if (widget.gallery != null && widget.gallery!.isNotEmpty)
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                final item = widget.gallery![index];
                final imageUrl = item.mediaUrl ?? item.thumbnailUrl;

                if (imageUrl.startsWith('http')) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(imageUrl),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 3,
                    initialScale: PhotoViewComputedScale.contained,
                    heroAttributes: PhotoViewHeroAttributes(tag: item.id),
                  );
                } else {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: AssetImage(imageUrl),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 3,
                    initialScale: PhotoViewComputedScale.contained,
                    heroAttributes: PhotoViewHeroAttributes(tag: item.id),
                  );
                }
              },
              itemCount: widget.gallery!.length,
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(
                  value: event == null
                      ? null
                      : event.cumulativeBytesLoaded /
                            (event.expectedTotalBytes ?? 1),
                ),
              ),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              pageController: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            )
          else
            _buildPhotoView(widget.mediaItem),

          // Bottom Info Bar
          if (_showAppBar)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _currentItem.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_currentItem.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        _currentItem.subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                    if (widget.gallery != null &&
                        widget.gallery!.length > 1) ...[
                      const SizedBox(height: 8),
                      Text(
                        '${_currentIndex + 1} / ${widget.gallery!.length}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
