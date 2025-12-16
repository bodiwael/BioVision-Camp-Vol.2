class User {
  final String id;
  final String name;
  final String email;
  final String nationalId;
  final String organization;
  final String phone;
  final String role;
  final bool attendHackathon;
  final String registrationId;
  final String timestamp;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.nationalId,
    required this.organization,
    required this.phone,
    required this.role,
    required this.attendHackathon,
    required this.registrationId,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'nationalId': nationalId,
      'organization': organization,
      'phone': phone,
      'role': role,
      'attendHackathon': attendHackathon,
      'registrationId': registrationId,
      'timestamp': timestamp,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      nationalId: json['nationalId'] ?? '',
      organization: json['organization'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      attendHackathon: json['attendHackathon'] == true || json['attendHackathon'] == 'true',
      registrationId: json['registrationId'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  // Convert to list for Google Sheets row
  List<dynamic> toSheetRow() {
    return [
      id,
      name,
      email,
      nationalId,
      organization,
      phone,
      role,
      attendHackathon.toString(),
      registrationId,
      timestamp,
    ];
  }

  // Create from Google Sheets row
  factory User.fromSheetRow(List<dynamic> row) {
    return User(
      id: row.length > 0 ? row[0].toString() : '',
      name: row.length > 1 ? row[1].toString() : '',
      email: row.length > 2 ? row[2].toString() : '',
      nationalId: row.length > 3 ? row[3].toString() : '',
      organization: row.length > 4 ? row[4].toString() : '',
      phone: row.length > 5 ? row[5].toString() : '',
      role: row.length > 6 ? row[6].toString() : '',
      attendHackathon: row.length > 7 ? row[7].toString().toLowerCase() == 'true' : false,
      registrationId: row.length > 8 ? row[8].toString() : '',
      timestamp: row.length > 9 ? row[9].toString() : '',
    );
  }
}
