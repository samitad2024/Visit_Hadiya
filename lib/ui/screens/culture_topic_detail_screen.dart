import 'package:flutter/material.dart';

class CultureTopicDetailScreen extends StatelessWidget {
  const CultureTopicDetailScreen({
    super.key,
    required this.title,
    required this.body,
  });
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(body, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
