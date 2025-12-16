# Google Sheets API Setup Guide

This guide will help you set up Google Sheets integration for the BioVision Camp app to store user registrations.

## Overview

The app uses Google Sheets as a simple backend database to store:
- User registration information
- National ID
- Login credentials (password hashes)
- Event preferences (hackathon participation, role, etc.)

## Step-by-Step Setup

### 1. Create a Google Sheet

1. Go to [Google Sheets](https://sheets.google.com)
2. Create a new spreadsheet
3. Name it: **"BioVision Camp Registrations"**
4. Rename the first sheet to: **"Users"**
5. The sheet URL will look like:
   ```
   https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID_HERE/edit
   ```
6. Copy the `SPREADSHEET_ID` from the URL

### 2. Set Up Column Headers

In the first row of your sheet, add these headers:

| A | B | C | D | E | F | G | H | I | J | K |
|---|---|---|---|---|---|---|---|---|---|---|
| ID | Name | Email | National ID | Organization | Phone | Role | Attend Hackathon | Registration ID | Timestamp | Password Hash |

### 3. Make the Sheet Public (Read-Only)

**Option A: Simple Public Access (Recommended for Testing)**
1. Click **Share** button (top right)
2. Click **Change to anyone with the link**
3. Set permission to **Viewer**
4. Click **Done**

**Option B: API Key Access (Recommended for Production)**
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable **Google Sheets API**:
   - Go to **APIs & Services** > **Library**
   - Search for "Google Sheets API"
   - Click **Enable**
4. Create API Key:
   - Go to **APIs & Services** > **Credentials**
   - Click **Create Credentials** > **API Key**
   - Copy your API key
   - (Optional) Restrict the key to Google Sheets API only

### 4. Configure the App

Open `lib/services/google_sheets_service.dart` and update:

```dart
class GoogleSheetsService {
  // Replace with your actual Spreadsheet ID
  static const String spreadsheetId = 'YOUR_SPREADSHEET_ID_HERE';

  // Replace with your actual API Key
  static const String apiKey = 'YOUR_API_KEY_HERE';

  // Sheet name (must match your Google Sheet tab name)
  static const String sheetName = 'Users';
  ...
}
```

**Example:**
```dart
static const String spreadsheetId = '1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t';
static const String apiKey = 'AIzaSyDAbCdEfGhIjKlMnOpQrStUvWxYz1234567';
static const String sheetName = 'Users';
```

### 5. Test the Connection

1. Run the app:
   ```bash
   flutter run
   ```

2. Try to register a new user

3. Check your Google Sheet - you should see the new user data appear!

## Sheet Structure Explained

### Columns:

1. **ID**: Unique user ID (timestamp-based)
2. **Name**: Full name of the user
3. **Email**: Email address (used for login)
4. **National ID**: Government-issued ID number
5. **Organization**: Company/University name
6. **Phone**: Contact number
7. **Role**: User type (Attendee, Speaker, Student, etc.)
8. **Attend Hackathon**: TRUE/FALSE for hackathon participation
9. **Registration ID**: Unique registration number for QR code
10. **Timestamp**: ISO 8601 timestamp of registration
11. **Password Hash**: SHA-256 hash of user password

### Sample Data Row:

```
1734393600000 | John Doe | john@example.com | 1234567890 | MIT | +1234567890 | Student | TRUE | 1734393600000 | e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 | 2025-12-16T15:30:00.000Z
```

## Security Considerations

### ⚠️ Important Security Notes:

1. **Password Storage**:
   - Passwords are hashed using SHA-256
   - This is better than plain text but NOT production-grade
   - For production, use proper authentication services (Firebase Auth, AWS Cognito, etc.)

2. **API Key Security**:
   - Never commit API keys to public repositories
   - Add `lib/services/google_sheets_service.dart` to `.gitignore` if it contains real keys
   - Use environment variables or Firebase Remote Config for production

3. **Sheet Permissions**:
   - Keep the sheet **View-only** for public access
   - Only the API key should have write access
   - Never give public edit access

4. **Data Privacy**:
   - This setup is suitable for hackathons/events
   - For handling sensitive data, use proper backend with encryption
   - Comply with GDPR/privacy regulations for your region

## Upgrading to Production

For a production app, consider:

1. **Firebase Authentication**: Replace custom auth with Firebase
2. **Firestore Database**: Use Firestore instead of Google Sheets
3. **Backend API**: Build a proper REST API with Node.js/Python
4. **Encryption**: Encrypt sensitive data at rest
5. **HTTPS Only**: Ensure all API calls use HTTPS
6. **Rate Limiting**: Add rate limiting to prevent abuse

## Troubleshooting

### Error: "API key not valid"
- Check if you copied the API key correctly
- Ensure Google Sheets API is enabled in your project
- Try creating a new API key

### Error: "Resource not found"
- Verify the Spreadsheet ID is correct
- Check if the sheet name matches exactly (case-sensitive)
- Ensure the sheet is shared/public

### Error: "User already exists"
- Check if the email is already registered in the sheet
- Look for duplicate emails in column C

### Data not appearing in sheet
- Check internet connection
- Verify API key permissions
- Look at Flutter console for error messages
- Ensure sheet headers match exactly

## API Limits

Google Sheets API has usage limits:
- **Read requests**: 300 per minute per user
- **Write requests**: 300 per minute per user

For high-traffic events, consider:
- Implementing caching
- Using batch operations
- Upgrading to a proper database

## Advanced Features

### Querying Data

You can add custom queries in `google_sheets_service.dart`:

```dart
// Get users by role
static Future<List<User>> getUsersByRole(String role) async {
  final allUsers = await getAllUsers();
  return allUsers.where((user) => user.role == role).toList();
}

// Get hackathon participants
static Future<List<User>> getHackathonParticipants() async {
  final allUsers = await getAllUsers();
  return allUsers.where((user) => user.attendHackathon).toList();
}
```

### Exporting Data

To export registrations:
1. Go to your Google Sheet
2. **File** > **Download** > **CSV** or **Excel**
3. Use the data for badges, certificates, analytics, etc.

## Support

If you need help:
1. Check the Flutter console for error messages
2. Verify your Google Sheet permissions
3. Test the API key in Google Cloud Console
4. Review the app logs

---

**Important**: This setup is designed for educational purposes and small-scale events. For production applications with sensitive data, implement proper security measures and use enterprise-grade authentication services.
