import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/chat_message.dart';
import '../models/chat_session.dart';
import '../services/ai_chat_service.dart';

/// Controller for managing chat state and interactions with AI service
class ChatController extends ChangeNotifier {
  static const String _sessionKey = 'chat_session';

  final AIChatService _aiService;

  ChatSession _session = ChatSession.create();
  bool _isTyping = false;
  String? _error;

  ChatController({AIChatService? aiService})
    : _aiService = aiService ?? MockAIChatService();

  // Getters
  ChatSession get session => _session;
  List<ChatMessage> get messages => _session.messages;
  bool get isTyping => _isTyping;
  String? get error => _error;
  bool get hasMessages => _session.messages.isNotEmpty;

  /// Load chat history from storage
  Future<void> loadSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionJson = prefs.getString(_sessionKey);

      if (sessionJson != null) {
        final data = jsonDecode(sessionJson) as Map<String, dynamic>;
        _session = ChatSession.fromJson(data);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading chat session: $e');
      // Continue with empty session if load fails
    }
  }

  /// Save current session to storage
  Future<void> _saveSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionJson = jsonEncode(_session.toJson());
      await prefs.setString(_sessionKey, sessionJson);
    } catch (e) {
      debugPrint('Error saving chat session: $e');
    }
  }

  /// Send a user message and get AI response
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    _error = null;

    // Create user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content.trim(),
      isUser: true,
      timestamp: DateTime.now(),
      status: ChatMessageStatus.sent,
    );

    // Add user message to session
    _session = _session.copyWith(
      messages: [..._session.messages, userMessage],
      updatedAt: DateTime.now(),
    );
    notifyListeners();

    // Save after user message
    await _saveSession();

    // Start typing indicator
    _isTyping = true;
    notifyListeners();

    try {
      // Prepare conversation history for API
      final history = _session.messages
          .where((m) => m.status == ChatMessageStatus.sent)
          .map(
            (m) => {
              'role': m.isUser ? 'user' : 'assistant',
              'content': m.content,
            },
          )
          .toList();

      // Get AI response
      final responseContent = await _aiService.sendMessage(
        userMessage.content,
        history.sublist(
          0,
          history.length - 1,
        ), // Exclude the message we just added
      );

      // Create AI message
      final aiMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: responseContent,
        isUser: false,
        timestamp: DateTime.now(),
        status: ChatMessageStatus.sent,
      );

      // Add AI message to session
      _session = _session.copyWith(
        messages: [..._session.messages, aiMessage],
        updatedAt: DateTime.now(),
      );

      // Save after AI response
      await _saveSession();
    } on AIChatException catch (e) {
      _error = e.message;

      // Add error message
      final errorMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: 'Error: ${e.message}',
        isUser: false,
        timestamp: DateTime.now(),
        status: ChatMessageStatus.error,
        error: e.message,
      );

      _session = _session.copyWith(
        messages: [..._session.messages, errorMessage],
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      _error = 'An unexpected error occurred';
      debugPrint('Chat error: $e');
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }

  /// Retry sending the last failed message
  Future<void> retryLastMessage() async {
    if (_session.messages.isEmpty) return;

    final lastMessage = _session.messages.last;

    // Find the user message before the error
    if (lastMessage.status == ChatMessageStatus.error &&
        _session.messages.length >= 2) {
      final userMessage = _session.messages[_session.messages.length - 2];

      if (userMessage.isUser) {
        // Remove the error message
        _session = _session.copyWith(
          messages: _session.messages.sublist(0, _session.messages.length - 1),
        );
        notifyListeners();

        // Resend the user message
        await sendMessage(userMessage.content);
      }
    }
  }

  /// Clear chat history and start new session
  Future<void> clearChat() async {
    _session = ChatSession.create();
    _error = null;
    _isTyping = false;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_sessionKey);
    } catch (e) {
      debugPrint('Error clearing chat session: $e');
    }
  }

  /// Delete a specific message
  void deleteMessage(String messageId) {
    _session = _session.copyWith(
      messages: _session.messages.where((m) => m.id != messageId).toList(),
      updatedAt: DateTime.now(),
    );
    notifyListeners();
    _saveSession();
  }

  /// Get suggested prompts for empty state
  List<String> getSuggestedPrompts() {
    return [
      'Tell me about Hadiya history',
      'What are popular festivals?',
      'Places to visit in Hadiya',
      'Learn about Hadiya culture',
      'Famous Hadiya leaders',
      'Hadiyigna language',
    ];
  }

  @override
  void dispose() {
    _saveSession();
    super.dispose();
  }
}
