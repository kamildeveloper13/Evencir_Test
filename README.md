# Evencir_Test
**Package	Version	Purpose**
flutter_bloc	^8.1.6	State management solution using BLoC/Cubit pattern. Separates business logic from UI, making code testable and maintainable.
equatable	^2.0.5	Simplifies equality comparisons in BLoC states. Helps avoid unnecessary widget rebuilds by properly comparing state objects.
get_it	^7.7.0	Service locator for dependency injection. Manages app-wide dependencies like Cubits, repositories, and services.
cupertino_icons	^1.0.8	Provides iOS-style icons for Cupertino widgets. Ensures consistent iconography across both Android and iOS platforms.
flutter_screenutil	Responsive UI design. Adapts layouts to different screen sizes and resolutions automatically.
flutter_svg	SVG image rendering. Used for vector icons and illustrations in the app.
flutter_bloc	State management (as mentioned above)

**Why These Choices?**

flutter_bloc over Provider: BLoC provides better separation of concerns, event-driven architecture, and easier testing

equatable: Essential for BLoC to detect state changes correctly and prevent unnecessary rebuilds

get_it: Simplifies dependency management without using BuildContext, making Cubits accessible anywhere

Current Implementation (Presentation Layer Focused)
Since this is a UI-focused project, I implemented:

**Layer	Components	Responsibility**
Pages	UI Screens	Display data, handle user interactions
Widgets	Reusable UI components	Encapsulate UI elements
Cubits	State management	Business logic, state changes
States	State classes	Define different UI states
Models	Data models	Structure data entities

**Feature Breakdown**
Nutrition Feature
Purpose: Display daily nutrition, workouts, and insights

Cubit: NutritionCubit - Manages loading/loaded/error states

UI Components: Week calendar strip, workout cards, insight cards

Plan/Training Feature
Purpose: Show training calendar and workout plans

Cubit: TrainingCalendarCubit - Manages calendar data

UI Components: Week views, day rows, workout badges

Mood Feature
Purpose: Track daily mood using interactive picker

Cubit: MoodCubit - Manages selected mood state

UI Components: Circular mood picker, mood faces, ring painter

Profile Feature
Purpose: User profile information (placeholder)

Future Scope: User settings, preferences, achievements

Navigation Feature
Purpose: Bottom navigation bar management

Cubit: NavigationCubit - Manages selected tab state

UI Components: Custom bottom nav bar with icons and labels

**Future Improvements**
Add Data Layer (API calls, local database)

Implement Repository pattern

Add Unit tests for Cubits

Add Integration tests

Implement Dependency Injection with get_it

Add animations and transitions

Implement deep linking

Add push notifications

**APK Link:**
https://drive.google.com/file/d/1l1YG8jCtEZxkR9dfkOLYgsCAaGyeA_wi/view?usp=drive_link

**App Screen Shots:**
https://drive.google.com/drive/folders/19pHXcOtsRQVLVnyPnaGPnJk_VVsYdv5G?usp=drive_link

**App Screen Recording:**
https://drive.google.com/file/d/1pwQ4tvZ81PMUROBepZHoFGfzLvVukmHe/view?usp=drive_link
