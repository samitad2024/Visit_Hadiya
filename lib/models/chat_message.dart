/// Represents a single chat message in the conversation
class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final ChatMessageStatus status;
  final String? error;

  ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.status = ChatMessageStatus.sent,
    this.error,
  });

  ChatMessage copyWith({
    String? id,
    String? content,
    bool? isUser,
    DateTime? timestamp,
    ChatMessageStatus? status,
    String? error,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'status': status.name,
      'error': error,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      content: json['content'] as String,
      isUser: json['isUser'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: ChatMessageStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ChatMessageStatus.sent,
      ),
      error: json['error'] as String?,
    );
  }
}

enum ChatMessageStatus { sending, sent, error }
