# Mini Feedback App

A Flutter application that allows users to submit feedback with ratings and view all submitted feedbacks. The app features theme customization (light/dark/system) and uses Hive for local storage.

## Features

- Submit feedback with:
  - Name
  - Email
  - Star rating (1-5)
  - Message
- View all submitted feedbacks
- Delete feedbacks
- Theme customization (light/dark/system)
- Local data persistence using Hive
- Form validation
- Responsive UI

## 📱 Screens

1. 🏠 **Home Screen**
   - Welcome message
   - Button to navigate to feedback form
   - Floating action button to view all feedbacks
   - Theme switcher in app bar

2. **Feedback Form Screen**
   - Form with validation for:
     - Name (minimum 3 characters, alphabets only)
     - Email (must end with common domains)
     - Star rating (required)
     - Feedback message (required)
   - Preview before submission

3. **Feedbacks Screen**
   - List of all submitted feedbacks
   - Star rating visualization
   - Delete functionality with confirmation
   - Empty state handling

## 🛠️ Technical Details

### Dependencies

- `hive_flutter`: For local storage
- `hive`: Core Hive package
- `hive_generator`: For generating Hive adapters
- `build_runner`: For running code generation

### Data Model

```dart
class Feed {
  final String name;
  final String email;
  final int rating;
  final String message;
}
```

### 💾 Storage

- Uses Hive boxes:
  - `feedbackBox`: Stores all feedback entries
  - `settings`: Stores app theme preference

### 🌓 Theme Management

- System detects and follows system theme by default
- Users can manually select light/dark theme
- Theme preference persists between app launches

## 🚀 Getting Started

1. Clone the repository
2. Run 
   ```bash
    flutter pub get
    ```
3. Generate Hive adapters with
    ```bash 
    flutter pub run build_runner build
    ```
4. Run the app with 
    ```bash
    flutter run
    ```

## Future Enhancements

- Add feedback editing capability
- Implement search/filter for feedbacks
- Add user authentication
- Support for cloud sync
- Export feedbacks as CSV/PDF
