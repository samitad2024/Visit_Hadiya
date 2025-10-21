# Hadiya Heritage - AI-Powered Cultural App

A cross‑platform Flutter app to showcase the culture, history, sites, and biographies of the Hadiya people (Hossana, Ethiopia). Built with Provider state management, clean feature folders, and early localization support.

## Features

### Core Features (MVP)
- Welcome + language selection (Hadiyigna, Amharic, English)
- Home sections with categories (History, Culture, Sites, Festivals, Media)
- History Timeline screen with historical sites and landmarks
- Culture & Traditions exploration with detailed content
- Famous Persons/Icons gallery with biographies
- Calendar with festivals and cultural events
- Media gallery with audio, video, and photo content
- Favorites system for bookmarking content
- Settings with theme, language, and accessibility options
- Device Preview enabled on web to emulate mobile frames

### AI Chatbot Feature ✨
Interactive AI assistant accessible via the "Explore" button in bottom navigation. Provides conversational exploration of Hadiya heritage with specialized knowledge and context.

## AI Chatbot Architecture

### Service Layer (`lib/services/ai_chat_service.dart`)
- **Abstract Interface**: `AIChatService` for pluggable AI providers
- **OpenAI Implementation**: `OpenAIChatService` with HTTP client, error handling, rate limiting
- **Mock Service**: `MockAIChatService` for development and testing without API keys
- **Custom Exception**: `AIChatException` for proper error handling

### State Management (`lib/controllers/chat_controller.dart`)
- **Provider Pattern**: Follows app's existing architecture with `ChangeNotifier`
- **Persistent Storage**: Chat history saved/loaded using `SharedPreferences`
- **Message Queue**: Handles sending, receiving, retry logic for failed messages
- **Session Management**: Create, clear, and manage conversation sessions

### Data Models (`lib/models/`)
- **ChatMessage**: Individual message with status, timestamp, error handling
- **ChatSession**: Conversation container with message history and metadata
- **JSON Serialization**: Full serialization support for persistent storage

### UI Components (`lib/ui/`)

#### Main Screen (`chatbot_screen.dart`)
- **Empty State**: Welcome message, feature highlights, suggestion chips
- **Message List**: Scrollable conversation with automatic scroll-to-bottom
- **Typing Indicator**: Animated dots during AI response generation
- **Error States**: Network errors, API failures with retry options
- **Clear Chat**: Dialog confirmation for conversation reset

#### Reusable Widgets
- **ChatMessageBubble**: User/AI message bubbles with timestamps, status indicators
- **ChatInput**: Multi-line text input with send button, enabled/disabled states
- **TypingIndicator**: Animated loading indicator for AI responses
- **SuggestionChips**: Quick-start prompts for common questions

### AI System Prompt
Specialized context for Hadiya heritage including:
- Historical knowledge (kingdoms, leaders, timeline)
- Cultural practices (festivals, traditions, customs)
- Geographic information (sites, attractions, landmarks)
- Language information (Hadiyigna basics, cultural significance)
- Travel recommendations and app navigation help

### Integration Points
- **Navigation**: "Explore" button routes to `/chat` screen
- **Theme System**: Follows app's Material 3 design with custom colors
- **Localization**: All UI text supports 3 languages (Hadiyigna, Amharic, English)
- **Provider Integration**: Works with existing `AppSettingsProvider` and `FavoritesService`

## Tech Stack

### Core Technologies
- **Flutter 3.x** with Dart 3.x for cross-platform development
- **Provider 6.x** for state management and dependency injection
- **Material 3** design system with custom theming
- **SharedPreferences** for local data persistence
- **Device Preview** for responsive design testing

### UI & Design
- **Google Fonts** (Nunito) for typography
- **Flutter SVG** for vector graphics and icons
- **Cached Network Image** for efficient image loading
- **Staggered Animations** for smooth list transitions
- **Photo View** for image viewing with zoom capabilities

### Media & Content
- **Audio Players** for traditional music and stories
- **Video Player** with YouTube integration for documentaries
- **Flutter Staggered Grid** for media gallery layouts
- **URL Launcher** for external links and maps integration
- **Share Plus** for content sharing capabilities

### AI & Networking
- **HTTP 1.1.0** for API communication with OpenAI/compatible services
- **JSON Serialization** for message persistence and API communication
- **Error Handling** with custom exceptions and retry mechanisms

### Development & Quality
- **Flutter Lints 5.x** for code quality enforcement
- **Intl** package for internationalization and date formatting
- **Analysis Options** configured for strict linting rules

## Project Structure

```
lib/
├── main.dart                    # App entry point with routing
├── controllers/                 # Provider-based state management
│   ├── chat_controller.dart     # AI chat state and logic
│   ├── culture_controller.dart  # Culture content management
│   └── ...
├── core/
│   ├── providers/              # Global app settings
│   └── theme/                  # Material 3 theming
├── data/                       # Mock repositories and data
├── l10n/                       # Localization (map-based, migrate to ARB)
├── models/                     # Data models and serialization
│   ├── chat_message.dart       # Chat message structure
│   ├── chat_session.dart       # Conversation session
│   └── ...
├── services/                   # External integrations
│   ├── ai_chat_service.dart    # AI service abstraction
│   ├── favorites_service.dart  # Bookmarking functionality
│   └── ...
└── ui/
    ├── screens/                # Main application screens
    │   ├── chatbot_screen.dart # AI chat interface
    │   ├── home_screen.dart    # App home with categories
    │   └── ...
    └── widgets/                # Reusable UI components
        ├── chat_message_bubble.dart
        ├── chat_input.dart
        ├── typing_indicator.dart
        └── ...
```

## Configuration & Setup

### Development Setup
```powershell
# Install dependencies
flutter pub get

# Run with device preview (web)
flutter run -d chrome

# Run on Android/iOS
flutter run
```

### AI Service Configuration
1. **Production**: Set OpenAI API key in environment or app settings
2. **Development**: Uses `MockAIChatService` by default for testing
3. **Fallback**: Graceful degradation when API unavailable

### Environment Variables (Optional)
- `OPENAI_API_KEY`: For production AI service integration
- `DART_VM_PRODUCT`: Disables DevicePreview in production builds

## Localization Strategy

### Current Implementation
- **Map-based system** for rapid development with 3 languages
- **Hadiyigna strings** marked as placeholders (TODO: verify with native speakers)
- **Amharic translations** for Ethiopian users
- **English fallback** for international accessibility

### Migration Path
- Replace with **ARB/intl workflow** for production
- Add **plural support** and **context-aware translations**
- Integrate with **translation management systems**

## Content Guidelines

### Cultural Sensitivity
- **Accuracy First**: All historical and cultural information verified
- **Community Input**: Collaborate with Hadiya cultural experts
- **Respectful Representation**: Avoid stereotypes or oversimplification
- **Source Attribution**: Credit all content sources and contributors

### AI Assistant Behavior
- **Culturally Appropriate**: Warm, respectful tone matching Hadiya hospitality
- **Knowledgeable**: Specialized in Hadiya heritage with accurate information
- **Helpful**: Guides users through app features and content discovery
- **Humble**: Acknowledges limitations and suggests exploring app sections

## Testing Strategy

### Automated Testing
- **Unit Tests**: Service layer, controllers, and models
- **Widget Tests**: UI components and user interactions
- **Integration Tests**: Full user flows including chat functionality

### Manual Testing
- **Device Testing**: Android, iOS, and web platforms
- **Accessibility**: Screen readers, keyboard navigation, text scaling
- **Network Conditions**: Offline usage, slow connections, API failures
- **Localization**: All three language variants

## Contributing Guidelines

### Development Workflow
1. **Feature Branch**: Create from main with descriptive name
2. **Code Quality**: Follow Flutter/Dart style guidelines
3. **Testing**: Add tests for new functionality
4. **Documentation**: Update README and inline documentation
5. **Pull Request**: Include description, screenshots, and testing notes

### Cultural Content
- **Verification Required**: All cultural content must be verified by Hadiya community members
- **Source Documentation**: Include sources and attribution for all historical claims
- **Community Review**: Cultural additions reviewed by project maintainers

## Deployment

### Web Deployment
- **GitHub Pages**: Automated deployment from main branch
- **PWA Support**: Offline capabilities and app-like experience
- **Responsive Design**: Device Preview ensures mobile compatibility

### Mobile App Stores
- **Android**: Google Play Store with Ethiopian market focus
- **iOS**: App Store with cultural and educational categorization
- **Local Distribution**: Direct APK distribution for Ethiopian users

---

**Mission**: Preserve and celebrate Hadiya heritage through accessible, interactive technology that connects people with their cultural roots and educates others about this rich Ethiopian culture.

**Vision**: Become the definitive digital resource for Hadiya culture, history, and heritage, fostering pride in Hadiya identity and promoting cultural understanding.
