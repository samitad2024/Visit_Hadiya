import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/chat_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/app_bottom_navigation.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/suggestion_chips.dart';

/// AI-powered chatbot screen for exploring Hadiya heritage
class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatController()..loadSession(),
      child: const _ChatbotView(),
    );
  }
}

class _ChatbotView extends StatefulWidget {
  const _ChatbotView();

  @override
  State<_ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<_ChatbotView> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.t('chat_title')),
        actions: [
          Consumer<ChatController>(
            builder: (context, chatController, _) {
              if (!chatController.hasMessages) return const SizedBox.shrink();

              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'clear') {
                    _showClearChatDialog(context, chatController);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        const Icon(Icons.clear_all),
                        const SizedBox(width: 8),
                        Text(loc.t('chat_clear')),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigation(selectedIndex: 1),
      body: Consumer<ChatController>(
        builder: (context, chatController, _) {
          return Column(
            children: [
              Expanded(
                child: chatController.hasMessages
                    ? _buildMessagesList(chatController)
                    : _buildEmptyState(context, chatController),
              ),
              if (chatController.isTyping) const TypingIndicator(),
              ChatInput(
                onSend: (message) {
                  chatController.sendMessage(message);
                  _scrollToBottom();
                },
                enabled: !chatController.isTyping,
                hintText: loc.t('chat_input_hint'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessagesList(ChatController chatController) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: chatController.messages.length,
      itemBuilder: (context, index) {
        final message = chatController.messages[index];
        return ChatMessageBubble(
          message: message,
          onRetry: message.status.name == 'error'
              ? () => chatController.retryLastMessage()
              : null,
          onDelete: () => chatController.deleteMessage(message.id),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, ChatController chatController) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          // AI Assistant Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primaryContainer,
                  theme.colorScheme.primary.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              Icons.smart_toy_rounded,
              size: 60,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),

          const SizedBox(height: 32),

          // Welcome Title
          Text(
            loc.t('chat_welcome_title'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Welcome Subtitle
          Text(
            loc.t('chat_welcome_subtitle'),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          // Features List
          _buildFeaturesList(context),

          const SizedBox(height: 32),

          // Suggestion Chips
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  loc.t('chat_suggestions_title'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SuggestionChips(
                suggestions: chatController.getSuggestedPrompts(),
                onSuggestionTap: (suggestion) {
                  chatController.sendMessage(suggestion);
                  _scrollToBottom();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final features = [
      {
        'icon': Icons.history_edu,
        'title': loc.t('chat_feature_history'),
        'subtitle': loc.t('chat_feature_history_desc'),
      },
      {
        'icon': Icons.celebration,
        'title': loc.t('chat_feature_culture'),
        'subtitle': loc.t('chat_feature_culture_desc'),
      },
      {
        'icon': Icons.place,
        'title': loc.t('chat_feature_places'),
        'subtitle': loc.t('chat_feature_places_desc'),
      },
      {
        'icon': Icons.help_outline,
        'title': loc.t('chat_feature_help'),
        'subtitle': loc.t('chat_feature_help_desc'),
      },
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'] as String,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      feature['subtitle'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showClearChatDialog(
    BuildContext context,
    ChatController chatController,
  ) {
    final loc = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.t('chat_clear_dialog_title')),
        content: Text(loc.t('chat_clear_dialog_message')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc.t('cancel')),
          ),
          FilledButton(
            onPressed: () {
              chatController.clearChat();
              Navigator.of(context).pop();
            },
            child: Text(loc.t('chat_clear')),
          ),
        ],
      ),
    );
  }
}
