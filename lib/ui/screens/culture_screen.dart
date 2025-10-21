import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/culture_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/app_bottom_navigation.dart';

class CultureScreen extends StatelessWidget {
  const CultureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CultureController()..load(),
      child: const _CultureView(),
    );
  }
}

class _CultureView extends StatelessWidget {
  const _CultureView();
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final topics = context.watch<CultureController>().topics;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(loc.t('hadiya_culture_title'))),
      bottomNavigationBar: const AppBottomNavigation(selectedIndex: 1),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemBuilder: (context, index) {
          final t = topics[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              title: Text(
                loc.t(t.titleKey),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              trailing: Icon(Icons.expand_more_rounded, color: cs.primary),
              children: [
                Text(
                  loc.t(t.bodyKey),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: topics.length,
      ),
    );
  }
}
