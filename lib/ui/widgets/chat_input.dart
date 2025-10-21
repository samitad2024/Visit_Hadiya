import 'package:flutter/material.dart';

/// Chat input field with send button
class ChatInput extends StatefulWidget {
  final Function(String) onSend;
  final bool enabled;
  final String? hintText;

  const ChatInput({
    super.key,
    required this.onSend,
    this.enabled = true,
    this.hintText,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && widget.enabled) {
      widget.onSend(text);
      _controller.clear();
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                maxLines: 5,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText:
                      widget.hintText ?? 'Ask me anything about Hadiya...',
                  hintStyle: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                onSubmitted: (_) => _handleSend(),
              ),
            ),
            const SizedBox(width: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: IconButton.filled(
                onPressed: (_hasText && widget.enabled) ? _handleSend : null,
                icon: const Icon(Icons.send_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: (_hasText && widget.enabled)
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surfaceContainerHighest,
                  foregroundColor: (_hasText && widget.enabled)
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface.withOpacity(0.3),
                  disabledBackgroundColor:
                      theme.colorScheme.surfaceContainerHighest,
                  disabledForegroundColor: theme.colorScheme.onSurface
                      .withOpacity(0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
