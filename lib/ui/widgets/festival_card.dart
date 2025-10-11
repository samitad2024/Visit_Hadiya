import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../models/festival_event.dart';

/// A card widget to display festival information
class FestivalCard extends StatelessWidget {
  final FestivalEvent festival;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showCategory;
  final bool compact;

  const FestivalCard({
    super.key,
    required this.festival,
    this.onTap,
    this.trailing,
    this.showCategory = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: InkWell(
        onTap: onTap,
        child: compact
            ? _buildCompactContent(context)
            : _buildFullContent(context),
      ),
    );
  }

  Widget _buildFullContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (festival.thumbnailUrl != null)
          Hero(
            tag: 'festival_${festival.id}',
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: festival.thumbnailUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.celebration,
                    size: 48,
                    color: colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showCategory)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CategoryChip(category: festival.category),
                ),
              Text(
                festival.titleKey,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat('MMM dd, yyyy').format(festival.date),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (festival.location != null) ...[
                    const SizedBox(width: 12),
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        festival.location!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              _StatusBadge(festival: festival),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: trailing!,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          if (festival.thumbnailUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: festival.thumbnailUrl!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: colorScheme.surfaceContainerHighest,
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.celebration,
                    color: colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
              ),
            )
          else
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.celebration,
                color: colorScheme.primary.withValues(alpha: 0.3),
              ),
            ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  festival.titleKey,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MMM dd, yyyy').format(festival.date),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                _StatusBadge(festival: festival, compact: true),
              ],
            ),
          ),

          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Category chip widget
class CategoryChip extends StatelessWidget {
  final FestivalCategory category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getCategoryColor(category, colorScheme),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getCategoryLabel(category),
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getCategoryColor(FestivalCategory category, ColorScheme scheme) {
    switch (category) {
      case FestivalCategory.religious:
        return scheme.primaryContainer;
      case FestivalCategory.cultural:
        return scheme.secondaryContainer;
      case FestivalCategory.harvest:
        return scheme.tertiaryContainer;
      case FestivalCategory.music:
        return scheme.errorContainer;
      case FestivalCategory.food:
        return Colors.orange.withValues(alpha: 0.2);
      case FestivalCategory.sport:
        return Colors.blue.withValues(alpha: 0.2);
      default:
        return scheme.surfaceContainerHighest;
    }
  }

  String _getCategoryLabel(FestivalCategory category) {
    return category.name.toUpperCase();
  }
}

/// Status badge showing if event is upcoming, happening, etc.
class _StatusBadge extends StatelessWidget {
  final FestivalEvent festival;
  final bool compact;

  const _StatusBadge({required this.festival, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String label;
    Color color;
    IconData icon;

    if (festival.isHappening) {
      label = 'HAPPENING NOW';
      color = Colors.green;
      icon = Icons.online_prediction;
    } else if (festival.isUpcoming) {
      final daysUntil = festival.daysUntil;
      if (daysUntil == 0) {
        label = 'TODAY';
        color = Colors.orange;
        icon = Icons.today;
      } else if (daysUntil == 1) {
        label = 'TOMORROW';
        color = Colors.orange;
        icon = Icons.event;
      } else if (daysUntil <= 7) {
        label = 'IN $daysUntil DAYS';
        color = colorScheme.primary;
        icon = Icons.schedule;
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: compact ? 12 : 14, color: color),
          SizedBox(width: compact ? 4 : 6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: compact ? 10 : 11,
            ),
          ),
        ],
      ),
    );
  }
}
