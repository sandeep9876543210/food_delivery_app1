Food Delivery App
This is a Flutter-based food delivery app built as a UI implementation of a design inspired by Dribbble. The app allows users to view food items, check details in a bottom sheet, and manage a cart with local sql database.

Features:
Home Screen
Horizontal list of featured food items
Vertical list of available food items
Food Item Details
Bottom sheet view for detailed food item information
Cart Screen
Add and remove items from the cart
View all items added to the cart
Screens and Functionalities
Home Screen:
Displays a horizontal list of food items.
Shows a vertical list of all food items with options to add items to the cart.
Food Item Details Bottom Sheet:
Allows users to view detailed information about each food item upon selection.
Cart Screen:
View all items added to the cart.
Remove items from the cart.
Getting Started:
Prerequisites
Ensure you have the following installed:
Flutter SDK
A code editor like Android Studio
Installation
Install dependencies:
flutter pub get
Running the App
Connect your device or start an emulator.
Run the app with:
flutter run
Project Structure:
lib/
├── main.dart            # Entry point of the app
├── screens/             # Screens: Home, Cart
└── widgets/             # Reusable widgets like food item cards, bottom sheet

Notes:
No external APIs are used; the app uses local sql database for funtionality.
