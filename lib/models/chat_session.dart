import 'chat_message.dart';

/// Represents a chat session with history
class ChatSession {
  final String id;
  final List<ChatMessage> messages;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatSession({
    required this.id,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
  });

  ChatSession copyWith({
    String? id,
    List<ChatMessage>? messages,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatSession(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messages': messages.map((m) => m.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'] as String,
      messages: (json['messages'] as List)
          .map((m) => ChatMessage.fromJson(m as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Creates a new empty session
  factory ChatSession.create() {
    final now = DateTime.now();
    return ChatSession(
      id: now.millisecondsSinceEpoch.toString(),
      messages: [],
      createdAt: now,
      updatedAt: now,
    );
  }
}
