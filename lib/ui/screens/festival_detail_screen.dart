import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/festival_event.dart';
import '../../controllers/favorites_controller.dart';
import '../widgets/festival_card.dart';

/// Detailed view of a festival event
class FestivalDetailScreen extends StatefulWidget {
  final FestivalEvent festival;

  const FestivalDetailScreen({super.key, required this.festival});

  @override
  State<FestivalDetailScreen> createState() => _FestivalDetailScreenState();
}

class _FestivalDetailScreenState extends State<FestivalDetailScreen> {
  final PageController _pageController = PageController();
  late FavoritesController _favoritesController;

  @override
  void initState() {
    super.initState();
    _favoritesController = FavoritesController()..loadFavorites();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _favoritesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ChangeNotifierProvider.value(
      value: _favoritesController,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            // App bar with image
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildImageCarousel(),
              ),
              actions: [
                Consumer<FavoritesController>(
                  builder: (context, favController, _) {
                    final isFavorite = favController.isFavorite(
                      widget.festival.id,
                    );

                    return IconButton(
                      onPressed: () =>
                          favController.toggleFavorite(widget.festival.id),
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black.withValues(alpha: 0.3),
                      ),
                    );
                  },
                ),
                IconButton(
                  onPressed: () => _shareFestival(),
                  icon: const Icon(Icons.share),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    CategoryChip(category: widget.festival.category),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      widget.festival.titleKey,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Date info card
                    _InfoCard(
                      icon: Icons.calendar_today,
                      title: 'Date',
                      content: _formatDateRange(),
                    ),

                    const SizedBox(height: 12),

                    // Location info card
                    if (widget.festival.location != null)
                      _InfoCard(
                        icon: Icons.location_on,
                        title: 'Location',
                        content: widget.festival.location!,
                        onTap: widget.festival.latitude != null
                            ? () => _openMap()
                            : null,
                      ),

                    const SizedBox(height: 12),

                    // Duration
                    if (widget.festival.duration != null)
                      _InfoCard(
                        icon: Icons.access_time,
                        title: 'Duration',
                        content: widget.festival.duration!,
                      ),

                    const SizedBox(height: 12),

                    // Entry fee
                    if (widget.festival.entryFee != null)
                      _InfoCard(
                        icon: Icons.payments,
                        title: 'Entry Fee',
                        content:
                            '${widget.festival.entryFee!.toStringAsFixed(2)} ETB',
                      ),

                    const SizedBox(height: 24),

                    // Description section
                    Text(
                      'About',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.festival.descriptionKey,
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),

                    // Activities section
                    if (widget.festival.activities.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Activities',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...widget.festival.activities.map(
                        (activity) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 20,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  activity,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    // Contact section
                    if (widget.festival.contactInfo != null ||
                        widget.festival.websiteUrl != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        'Contact Information',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (widget.festival.contactInfo != null)
                        _ContactButton(
                          icon: Icons.phone,
                          label: widget.festival.contactInfo!,
                          onTap: () =>
                              _makePhoneCall(widget.festival.contactInfo!),
                        ),
                      if (widget.festival.websiteUrl != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: _ContactButton(
                            icon: Icons.language,
                            label: 'Visit Website',
                            onTap: () =>
                                _openWebsite(widget.festival.websiteUrl!),
                          ),
                        ),
                    ],

                    const SizedBox(height: 32),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _shareFestival(),
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: widget.festival.latitude != null
                                ? () => _openMap()
                                : null,
                            icon: const Icon(Icons.directions),
                            label: const Text('Directions'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    final images = widget.festival.imageUrls.isNotEmpty
        ? widget.festival.imageUrls
        : [widget.festival.thumbnailUrl ?? ''];

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Hero(
              tag: 'festival_${widget.festival.id}',
              child: CachedNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.celebration, size: 80),
                ),
              ),
            );
          },
        ),
        if (images.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: images.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _formatDateRange() {
    final dateFormat = DateFormat('MMMM dd, yyyy');
    if (widget.festival.isMultiDay) {
      return '${dateFormat.format(widget.festival.date)} - ${dateFormat.format(widget.festival.endDate!)}';
    }
    return dateFormat.format(widget.festival.date);
  }

  void _shareFestival() {
    Share.share(
      '${widget.festival.titleKey}\n'
      '${_formatDateRange()}\n'
      '${widget.festival.location ?? ''}\n\n'
      'Shared from Visit Hadiya App',
    );
  }

  Future<void> _openMap() async {
    if (widget.festival.latitude != null && widget.festival.longitude != null) {
      final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query='
        '${widget.festival.latitude},${widget.festival.longitude}',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _openWebsite(String websiteUrl) async {
    final url = Uri.parse(websiteUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final VoidCallback? onTap;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
