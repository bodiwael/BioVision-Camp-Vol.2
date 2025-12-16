# Authentication Features - Quick Guide

## 🎉 What's New

Your BioVision Camp app now has a complete authentication system with Google Sheets as the backend!

## ✨ New Features

### 1. **User Registration** 📝
- Full name, email, password (with confirmation)
- **National ID** field (required)
- Organization and phone number
- Role selection (Attendee, Speaker, Student, etc.)
- Hackathon participation checkbox
- All data saved to Google Sheets

### 2. **User Login** 🔐
- Email and password authentication
- Password hashing with SHA-256
- Session management
- Persistent login (stays logged in)

### 3. **Splash Screen** 🌟
- Beautiful animated splash screen
- Automatic authentication check
- Redirects to home if logged in, login screen if not

### 4. **Personalized Home** 🏠
- Greeting with user's first name
- Logout button in app bar
- All existing features accessible

### 5. **Google Sheets Integration** 📊
- User data stored in Google Sheets
- Easy to export for badges, certificates
- No backend server needed!

## 🚀 How to Use

### First Time Setup (Required!)

1. **Create Google Sheet**:
   - Go to [Google Sheets](https://sheets.google.com)
   - Create new spreadsheet: "BioVision Camp Registrations"
   - Add sheet tab named "Users"

2. **Add Headers** (Row 1):
   ```
   ID | Name | Email | National ID | Organization | Phone | Role | Attend Hackathon | Registration ID | Timestamp | Password Hash
   ```

3. **Get Spreadsheet ID**:
   - From URL: `https://docs.google.com/spreadsheets/d/YOUR_ID_HERE/edit`
   - Copy the ID part

4. **Get API Key**:
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create project (or use existing)
   - Enable Google Sheets API
   - Create API Key in Credentials

5. **Configure App**:
   Open `lib/services/google_sheets_service.dart`:
   ```dart
   static const String spreadsheetId = 'YOUR_SPREADSHEET_ID';
   static const String apiKey = 'YOUR_API_KEY';
   ```

6. **Run the App**:
   ```bash
   flutter pub get
   flutter run
   ```

## 📱 App Flow

```
App Start
    ↓
Splash Screen (2 seconds)
    ↓
Check Authentication
    ↓
┌───────────┴───────────┐
│                       │
Not Logged In      Logged In
    ↓                   ↓
Login Screen       Home Screen
    ↓                   ↓
Register Option    User Info Displayed
    ↓                   ↓
Fill Form          Access All Features
    ↓                   ↓
Submit             Logout Option
    ↓
Saved to Google Sheets
    ↓
Redirect to Home
```

## 🔒 Security Features

- ✅ Password hashing with SHA-256
- ✅ Session tokens stored locally
- ✅ Passwords never stored in plain text
- ✅ Email uniqueness validation
- ✅ Form input validation

## 📊 What Gets Saved

When a user registers, the following data is saved to Google Sheets:

1. **ID**: Unique timestamp-based ID
2. **Name**: Full name
3. **Email**: Used for login
4. **National ID**: Government ID number
5. **Organization**: Company/University
6. **Phone**: Contact number
7. **Role**: Selected role (Attendee, Speaker, etc.)
8. **Attend Hackathon**: TRUE/FALSE
9. **Registration ID**: For QR code
10. **Timestamp**: ISO 8601 format
11. **Password Hash**: SHA-256 hash

## 🎯 Use Cases

### For Event Organizers:
1. **Registration Tracking**: See all registrations in one Google Sheet
2. **Export Data**: Download as Excel/CSV for badges
3. **Hackathon List**: Filter users who want to join hackathon
4. **Role Analytics**: See distribution of attendees, speakers, etc.

### For Attendees:
1. **One-Time Registration**: Register once, login anytime
2. **QR Code Access**: Login to see your QR code
3. **Profile Management**: View your registration details
4. **Event Access**: Navigate all event features

## 🛠️ Customization

### Add Custom Fields

1. Update `User` model in `lib/models/user.dart`:
```dart
class User {
  final String customField;
  // ... existing fields
}
```

2. Update registration form in `lib/screens/auth_registration_screen.dart`

3. Update Google Sheets headers to match

### Change Password Requirements

Edit in `lib/screens/auth_registration_screen.dart`:
```dart
validator: (value) {
  if (value!.length < 8) return 'Password must be at least 8 characters';
  // Add more rules
}
```

## 📖 Documentation

- **Setup Guide**: See `GOOGLE_SHEETS_SETUP.md` for detailed setup
- **Main README**: See `README.md` for app overview
- **Gradle Setup**: See `GRADLE_FIX.md` for build issues

## ⚠️ Important Notes

### For Testing/Hackathons:
- ✅ Current setup is perfect
- ✅ Easy to deploy
- ✅ No backend needed

### For Production:
Consider upgrading to:
- Firebase Authentication
- Firestore Database
- Proper encryption
- HTTPS-only API
- Rate limiting

See `GOOGLE_SHEETS_SETUP.md` for production recommendations.

## 🐛 Troubleshooting

### "Failed to register"
- Check internet connection
- Verify Google Sheet is public
- Check API key is correct
- Ensure spreadsheet ID is correct

### "User already exists"
- Check if email is already in Google Sheet
- Use a different email
- Delete duplicate entry from sheet

### "Login failed"
- Check email spelling
- Verify password is correct
- Ensure user is registered

### Data not appearing in sheet
- Check API key permissions
- Verify sheet name is "Users"
- Check column headers match exactly

## 📞 Support

For help:
1. Check `GOOGLE_SHEETS_SETUP.md`
2. Review Flutter console for errors
3. Verify Google Sheet permissions
4. Test API key in Google Cloud Console

---

**Happy Coding!** 🎉🧬

Your BioVision Camp app now has enterprise-level authentication with zero backend costs!
