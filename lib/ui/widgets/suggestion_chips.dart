import 'package:flutter/material.dart';

/// Suggestion chips for quick prompts
class SuggestionChips extends StatelessWidget {
  final List<String> suggestions;
  final Function(String) onSuggestionTap;

  const SuggestionChips({
    super.key,
    required this.suggestions,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: suggestions.map((suggestion) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(suggestion),
              avatar: Icon(
                Icons.lightbulb_outline,
                size: 18,
                color: theme.colorScheme.primary,
              ),
              onPressed: () => onSuggestionTap(suggestion),
              backgroundColor: theme.colorScheme.primaryContainer.withOpacity(
                0.3,
              ),
              side: BorderSide(
                color: theme.colorScheme.primary.withOpacity(0.3),
              ),
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
