import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/providers/app_settings_provider.dart';
import '../../l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _selectedCode = 'hdy';

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final settings = context.watch<AppSettingsProvider>();
    _selectedCode ??= settings.languageCode;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;
            final content = _buildContent(context, loc, settings, isWide);
            if (isWide) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: content,
                ),
              );
            }
            return content;
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppLocalizations loc,
    AppSettingsProvider settings,
    bool isWide,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image header
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: const Color(0xFF121416)),
                  SvgPicture.asset(
                    'images/hadiy_nefera.png',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(AppColors.background),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Title
          Text(
            loc.t('welcome_title'),
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(height: 1.2),
          ),
          const SizedBox(height: Spacing.lg),
          // Subtitle
          Text(
            loc.t('welcome_subtitle'),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 28),
          Text(
            loc.t('select_language'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _LanguageTile(
            title: 'English',
            isSelected: _selectedCode == 'en',
            onTap: () => setState(() => _selectedCode = 'en'),
          ),
          _LanguageTile(
            title: 'አማርኛ (Amharic)',
            isSelected: _selectedCode == 'am',
            onTap: () => setState(() => _selectedCode = 'am'),
          ),
          _LanguageTile(
            title: 'Hadiyigna',
            isSelected: _selectedCode == 'hdy',
            onTap: () => setState(() => _selectedCode = 'hdy'),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedCode == null
                  ? null
                  : () {
                      if (_selectedCode != null) {
                        settings.setLanguage(_selectedCode!);
                      }
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
              child: Text(loc.t('continue')),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? cs.primary : const Color(AppColors.outline),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 16, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
