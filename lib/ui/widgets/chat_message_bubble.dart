import 'package:flutter/material.dart';
import '../../models/chat_message.dart';

/// Message bubble widget for displaying chat messages
class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onRetry;
  final VoidCallback? onDelete;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.onRetry,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isUser;
    final isError = message.status == ChatMessageStatus.error;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              radius: 18,
              child: Icon(
                Icons.smart_toy_rounded,
                size: 20,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: GestureDetector(
              onLongPress: onDelete,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isError
                      ? theme.colorScheme.errorContainer.withOpacity(0.3)
                      : isUser
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: Radius.circular(isUser ? 20 : 4),
                    bottomRight: Radius.circular(isUser ? 4 : 20),
                  ),
                  border: isError
                      ? Border.all(
                          color: theme.colorScheme.error.withOpacity(0.5),
                        )
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isError && message.error != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 16,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Failed to send',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                    Text(
                      message.content,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isUser
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(message.timestamp),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color:
                                (isUser
                                        ? theme.colorScheme.onPrimaryContainer
                                        : theme.colorScheme.onSurface)
                                    .withOpacity(0.6),
                          ),
                        ),
                        if (isError && onRetry != null) ...[
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: onRetry,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.refresh,
                                    size: 14,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Retry',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              radius: 18,
              child: Icon(
                Icons.person,
                size: 20,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }
}
