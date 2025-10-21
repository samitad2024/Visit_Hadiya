import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/asset_image.dart';
import 'package:provider/provider.dart';

import '../../controllers/history_controller.dart';
import '../../l10n/app_localizations.dart';
import '../../data/mock/mock_historical_sites_repository.dart';
import '../../models/historical_site.dart';

class HistoryTimelineScreen extends StatelessWidget {
  const HistoryTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistoryController()..load(),
      child: const _HistoryView(),
    );
  }
}

class _HistoryView extends StatelessWidget {
  const _HistoryView();
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final events = context.watch<HistoryController>().events;
    final cs = Theme.of(context).colorScheme;
    // Build a lookup of known visiting sites by id so we can attach map actions
    final sites = const MockHistoricalSitesRepository().fetchSites();
    final Map<String, HistoricalSite> siteById = {
      for (final s in sites) s.id: s,
    };
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(loc.t('hadiya_history')),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: events.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final e = events[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // timeline column
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: cs.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: cs.primary, width: 2),
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 100,
                      color: cs.primary.withOpacity(0.25),
                    ),
                  ],
                ),
              ),
              // card
              Expanded(
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AssetImageOrSvg(
                                  e.imageAsset,
                                  fit: BoxFit.cover,
                                ),
                                if (siteById[e.id]?.latitude != null &&
                                    siteById[e.id]?.longitude != null)
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: _MapQuickButton(
                                      tooltip: 'Open in Google Maps',
                                      onTap: () {
                                        final s = siteById[e.id]!;
                                        _openMap(s.latitude!, s.longitude!);
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          loc.t(e.titleKey),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          loc.t(e.subtitleKey),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<void> _openMap(double lat, double lng) async {
  final url = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
  );
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

class _MapQuickButton extends StatelessWidget {
  const _MapQuickButton({required this.onTap, this.tooltip});
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: tooltip ?? 'Map',
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.9),
        shape: const CircleBorder(),
        elevation: 2,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.map, color: theme.colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
