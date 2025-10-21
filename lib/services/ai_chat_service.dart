import 'dart:convert';
import 'package:http/http.dart' as http;

/// Abstract AI chat service interface
abstract class AIChatService {
  Future<String> sendMessage(String message, List<Map<String, String>> history);

  /// Get system prompt for Hadiya Heritage context
  String getSystemPrompt();
}

/// OpenAI-compatible chat service implementation
class OpenAIChatService implements AIChatService {
  final String apiKey;
  final String baseUrl;
  final String model;
  final int maxTokens;
  final double temperature;

  OpenAIChatService({
    required this.apiKey,
    this.baseUrl = 'https://api.openai.com/v1',
    this.model = 'gpt-3.5-turbo',
    this.maxTokens = 500,
    this.temperature = 0.7,
  });

  @override
  String getSystemPrompt() {
    return '''You are a knowledgeable and friendly AI assistant for the Hadiya Heritage app, dedicated to sharing information about the Hadiya people of Ethiopia. Your role is to:

1. Provide accurate, culturally respectful information about Hadiya history, culture, traditions, language (Hadiyigna), festivals, historical sites, and notable figures.
2. Help visitors plan their trips to Hadiya region, including recommendations for sites, events, and cultural experiences.
3. Answer questions about the app's features and content.
4. Be conversational, warm, and engaging while maintaining cultural sensitivity.
5. When you don't know something specific, acknowledge it and suggest related topics or encourage users to explore the app's sections.

Keep responses concise (2-3 paragraphs max) and culturally appropriate. Emphasize the rich heritage and welcoming nature of the Hadiya people.''';
  }

  @override
  Future<String> sendMessage(
    String message,
    List<Map<String, String>> history,
  ) async {
    try {
      final messages = [
        {'role': 'system', 'content': getSystemPrompt()},
        ...history,
        {'role': 'user', 'content': message},
      ];

      final response = await http.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': model,
          'messages': messages,
          'max_tokens': maxTokens,
          'temperature': temperature,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'] as String;
        return content.trim();
      } else if (response.statusCode == 401) {
        throw AIChatException(
          'Invalid API key. Please check your configuration.',
        );
      } else if (response.statusCode == 429) {
        throw AIChatException('Rate limit exceeded. Please try again later.');
      } else {
        throw AIChatException(
          'Failed to get response: ${response.statusCode} - ${response.body}',
        );
      }
    } on http.ClientException catch (e) {
      throw AIChatException('Network error: ${e.message}');
    } catch (e) {
      if (e is AIChatException) rethrow;
      throw AIChatException('Unexpected error: $e');
    }
  }
}

/// Mock AI chat service for testing and development
class MockAIChatService implements AIChatService {
  final Duration responseDelay;
  final bool shouldFail;

  MockAIChatService({
    this.responseDelay = const Duration(seconds: 1),
    this.shouldFail = false,
  });

  @override
  String getSystemPrompt() {
    return 'Mock AI Assistant for Hadiya Heritage';
  }

  @override
  Future<String> sendMessage(
    String message,
    List<Map<String, String>> history,
  ) async {
    // Simulate network delay
    await Future.delayed(responseDelay);

    if (shouldFail) {
      throw AIChatException('Mock service failure');
    }

    // Generate contextual mock responses based on message content
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('hello') ||
        lowerMessage.contains('hi') ||
        lowerMessage.contains('hey')) {
      return "Hello! Welcome to Hadiya Heritage. I'm here to help you explore the rich culture, history, and traditions of the Hadiya people. What would you like to know about?";
    }

    if (lowerMessage.contains('history')) {
      return "The Hadiya people have a fascinating history dating back centuries. The region is home to important archaeological sites like the Tiya Stones, a UNESCO World Heritage site. The Hadiya Kingdom was a powerful state in medieval Ethiopia. Would you like to know more about specific historical periods or sites?";
    }

    if (lowerMessage.contains('culture') ||
        lowerMessage.contains('tradition')) {
      return "Hadiya culture is rich with vibrant traditions! Music and dance play a central role in celebrations, with traditional instruments like the masenqo. The Hadiyigna language is spoken by hundreds of thousands. Important customs emphasize respect for elders, hospitality, and community support. What aspect of culture interests you most?";
    }

    if (lowerMessage.contains('festival') ||
        lowerMessage.contains('celebration')) {
      return "Hadiya festivals are colorful celebrations of culture and heritage! They mark important occasions like harvests, religious holidays, and cultural events. These gatherings feature traditional music, dance, food, and bring communities together. Check the Calendar section in the app to see upcoming festivals!";
    }

    if (lowerMessage.contains('visit') ||
        lowerMessage.contains('site') ||
        lowerMessage.contains('place')) {
      return "There are many amazing places to visit in the Hadiya region! Popular sites include Chebera Churchura National Park with diverse wildlife, Lake Wonchi (a beautiful crater lake), the historic Tiya Stones, and Adadi Mariam rock-hewn church. Each offers unique experiences. Would you like details about any specific site?";
    }

    if (lowerMessage.contains('food') || lowerMessage.contains('cuisine')) {
      return "Hadiya cuisine features delicious traditional dishes made with local ingredients. Sharing food is an important cultural practice that strengthens community bonds, especially during festivals and celebrations. Traditional preparation methods and recipes are passed down through generations.";
    }

    if (lowerMessage.contains('language') ||
        lowerMessage.contains('hadiyigna')) {
      return "Hadiyigna is the native language of the Hadiya people, part of the Cushitic branch of the Afroasiatic language family. It's spoken by hundreds of thousands in southern Ethiopia and is a vital symbol of Hadiya identity. The language features several dialects and has a rich oral tradition.";
    }

    if (lowerMessage.contains('help') ||
        lowerMessage.contains('how') ||
        lowerMessage.contains('what')) {
      return "I can help you learn about Hadiya history, culture, traditions, language, festivals, historical sites, and notable figures. I can also guide you through the app's features. Try asking about specific topics like 'Tell me about Hadiya history' or 'What festivals are celebrated?' What would you like to explore?";
    }

    // Default response
    return "That's an interesting question about Hadiya! The Hadiya people of southern Ethiopia have a rich cultural heritage with fascinating history, traditions, and sites to explore. Could you be more specific about what you'd like to know? I can help with history, culture, festivals, sites, or general travel information.";
  }
}

/// Custom exception for AI chat errors
class AIChatException implements Exception {
  final String message;

  AIChatException(this.message);

  @override
  String toString() => message;
}
