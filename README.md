# 🧬 BioVision Camp Vol.2 - Flutter Event App

A beautiful, animated Flutter application for the BioVision Camp Vol.2 event, featuring a modern and colorful UI with comprehensive event information, registration system, and QR code generation.

## ✨ Features

### 📱 **Main Screens**
- **Splash Screen**: Animated splash with automatic auth check
- **Login/Register**: Secure authentication system with password hashing
- **Home Dashboard**: Personalized dashboard with user greeting and logout
- **Event Agenda**: Interactive timeline view showing the complete event schedule
- **Featured Speakers**: Profile cards with detailed speaker information and topics
- **Hackathon Details**: Complete information about prizes, themes, rules, and timeline
- **Event Information**: Venue details, facilities, contact information
- **Registration System**: Complete form with National ID and Google Sheets integration
- **QR Code Generator**: Automatic QR code generation for registration desk check-in

### 🎨 **Design Highlights**
- Modern Material Design 3 with custom color scheme
- Smooth animations using flutter_animate package
- Gradient backgrounds and colorful UI elements
- Beautiful card-based layouts with shadows
- Custom Google Fonts (Poppins) for typography
- Emoji icons for visual appeal
- Responsive design for various screen sizes

### 🛠️ **Technical Features**
- **Authentication System**: Login/Register with email and password
- **Google Sheets Integration**: Store user data in Google Sheets (backend-less)
- **Password Security**: SHA-256 password hashing
- **Session Management**: Persistent login with SharedPreferences
- **National ID**: Required field for registration verification
- Form validation for all inputs
- Local data persistence using SharedPreferences
- QR code generation with user data
- Clean architecture with separate screens, models, and services
- Reusable widgets and components

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Google Account (for Google Sheets integration)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/bodiwael/BioVision-Camp-Vol.2.git
cd BioVision-Camp-Vol.2
```

2. Install dependencies:
```bash
flutter pub get
```

3. **Set up Google Sheets** (REQUIRED):
   - Follow the detailed guide in [`GOOGLE_SHEETS_SETUP.md`](GOOGLE_SHEETS_SETUP.md)
   - Create a Google Sheet for storing user data
   - Get your API Key and Spreadsheet ID
   - Update `lib/services/google_sheets_service.dart` with your credentials

4. Run the app:
```bash
flutter run
```

## 📦 Dependencies

- **google_fonts** (^6.1.0): Custom typography
- **qr_flutter** (^4.1.0): QR code generation
- **flutter_animate** (^4.5.0): Smooth animations
- **intl** (^0.19.0): Date and time formatting
- **shared_preferences** (^2.2.2): Local data storage & session management
- **url_launcher** (^6.2.4): External URL handling
- **http** (^1.2.0): API requests to Google Sheets
- **crypto** (^3.0.3): Password hashing with SHA-256
- **googleapis** (^13.2.0): Google Sheets API integration
- **googleapis_auth** (^1.6.0): Google API authentication

## 📂 Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/                            # Data models
│   ├── user.dart                      # User model with Google Sheets mapping
│   ├── speaker.dart
│   └── agenda_item.dart
├── screens/                           # UI screens
│   ├── splash_screen.dart            # Splash with auth check
│   ├── login_screen.dart             # Login screen
│   ├── auth_registration_screen.dart # Registration with Google Sheets
│   ├── home_screen.dart              # Dashboard with user info
│   ├── agenda_screen.dart
│   ├── speakers_screen.dart
│   ├── hackathon_screen.dart
│   ├── event_details_screen.dart
│   └── registration_screen.dart      # QR code display
├── services/                          # Business logic
│   ├── auth_service.dart             # Authentication service
│   └── google_sheets_service.dart    # Google Sheets API integration
└── utils/                             # Utilities
    └── sample_data.dart              # Sample event data
```

## 🎯 App Features Breakdown

### 1. Home Screen
- Animated welcome section with event branding
- Grid menu with 6 main navigation options
- Quick info cards for venue and duration
- Gradient backgrounds with multiple colors

### 2. Agenda Screen
- Timeline-based layout
- Color-coded events by type (sessions, workshops, breaks, hackathon)
- Time badges and speaker information
- Smooth scroll animations

### 3. Speakers Screen
- Profile cards with gradient headers
- Speaker photos (emoji placeholders)
- Detailed modal view on tap
- Organization and topic information

### 4. Hackathon Screen
- Prize pool display with medal emojis
- Challenge themes with icons
- Rules and guidelines section
- 24-hour timeline breakdown

### 5. Event Details Screen
- Comprehensive about section
- Venue with address and transportation
- Date/time information in cards
- Facilities grid
- Contact information

### 6. Registration Screen
- Multi-field form with validation
- Role selector with chip UI
- Hackathon participation checkbox
- QR code generation after registration
- Persistent storage of registration data
- Edit capability for registered users

## 🎨 Color Scheme

- **Primary**: #6C63FF (Purple)
- **Secondary**: #FF6584 (Pink)
- **Accent**: #00D4FF (Cyan)
- **Success**: #4CAF50 (Green)
- **Warning**: #FFC107 (Amber)
- **Hackathon**: #9C27B0 (Deep Purple)

## 🔧 Customization

### Adding New Speakers
Edit `lib/utils/sample_data.dart` and add to the `getSpeakers()` method:

```dart
Speaker(
  name: 'Your Name',
  title: 'Your Title',
  company: 'Company Name',
  bio: 'Biography...',
  imageUrl: '👤',
  topic: 'Talk Topic',
),
```

### Adding Agenda Items
Edit `lib/utils/sample_data.dart` and add to the `getAgenda()` method:

```dart
AgendaItem(
  time: '10:00 AM',
  title: 'Session Title',
  description: 'Description...',
  speaker: 'Speaker Name',
  type: 'session', // session, workshop, break, hackathon
),
```

## 📱 Screenshots

The app features:
- Vibrant color gradients
- Smooth page transitions
- Interactive cards and buttons
- Form validation feedback
- QR code display for registration

## 🤝 Contributing

Contributions are welcome! Feel free to submit pull requests or open issues.

## 📄 License

This project is open source and available for educational purposes.

## 👥 Event Information

**BioVision Camp Vol.2**
- **Date**: December 20-21, 2025
- **Venue**: BioTech Innovation Center, Silicon Valley, CA
- **Theme**: Where Biology Meets Technology

---

Built with ❤️ using Flutter