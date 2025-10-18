import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/historical_sites_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/asset_image.dart';

class HistoricalSitesScreen extends StatelessWidget {
  const HistoricalSitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HistoricalSitesController()..load(),
      child: const _HistoricalSitesView(),
    );
  }
}

class _HistoricalSitesView extends StatelessWidget {
  const _HistoricalSitesView();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final controller = context.watch<HistoricalSitesController>();
    final sites = controller.sites;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.t('home_sites_title')),
        leading: BackButton(onPressed: () => Navigator.of(context).maybePop()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: controller.setQuery,
              decoration: InputDecoration(
                hintText: 'Search historical sites...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Explore the rich history and natural beauty of Hadiya, Ethiopia. From ancient stelae to stunning landscapes, there's something for everyone.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: sites.length,
              itemBuilder: (context, index) {
                final s = sites[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: AssetImageOrSvg(
                            s.imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc.t(s.nameKey),
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Expanded(
                                child: Text(
                                  loc.t(s.subtitleKey),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey[600]),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Icon(
                                  Icons.map,
                                  color: Colors.blue[300],
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Integrate with map screen
                },
                icon: const Icon(Icons.map),
                label: const Text('View All on Map'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
