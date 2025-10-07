import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconDetailScreen extends StatelessWidget {
  const IconDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.asset,
  });
  final String title;
  final String subtitle;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(asset, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
