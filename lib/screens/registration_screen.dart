import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegistrationScreen extends StatefulWidget {
  final bool showQR;

  const RegistrationScreen({super.key, this.showQR = false});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _organizationController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedRole = 'Attendee';
  bool _attendHackathon = false;
  bool _isRegistered = false;
  Map<String, dynamic>? _registrationData;

  final List<String> _roles = [
    'Attendee',
    'Speaker',
    'Sponsor',
    'Student',
    'Researcher',
    'Developer',
  ];

  @override
  void initState() {
    super.initState();
    _loadRegistration();
  }

  Future<void> _loadRegistration() async {
    final prefs = await SharedPreferences.getInstance();
    final registrationJson = prefs.getString('registration');
    if (registrationJson != null) {
      setState(() {
        _registrationData = json.decode(registrationJson);
        _isRegistered = true;
      });
    }
  }

  Future<void> _saveRegistration() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': _nameController.text,
        'email': _emailController.text,
        'organization': _organizationController.text,
        'phone': _phoneController.text,
        'role': _selectedRole,
        'hackathon': _attendHackathon,
        'registrationId': DateTime.now().millisecondsSinceEpoch.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('registration', json.encode(data));

      setState(() {
        _registrationData = data;
        _isRegistered = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! 🎉'),
            backgroundColor: Color(0xFF4CAF50),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showQR || _isRegistered) {
      return _buildQRView();
    }
    return _buildRegistrationForm();
  }

  Widget _buildRegistrationForm() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Registration'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF4CAF50).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        '📝',
                        style: TextStyle(fontSize: 50),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Register for BioVision Camp',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Fill in your details to join us',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(duration: 500.ms),
                const SizedBox(height: 30),
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter your name';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter your email';
                    if (!value!.contains('@')) return 'Please enter a valid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _organizationController,
                  label: 'Organization',
                  icon: Icons.business,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter your organization';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter your phone number';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildRoleSelector(),
                const SizedBox(height: 16),
                _buildHackathonCheckbox(),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _saveRegistration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Complete Registration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ).animate(delay: 400.ms).scale(duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF4CAF50)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF4CAF50)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.badge, color: Color(0xFF4CAF50)),
              SizedBox(width: 8),
              Text(
                'Your Role',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _roles.map((role) {
              final isSelected = _selectedRole == role;
              return GestureDetector(
                onTap: () => setState(() => _selectedRole = role),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF4CAF50)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    role,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHackathonCheckbox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: CheckboxListTile(
        title: const Text(
          'I want to participate in the Hackathon',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Text(
          '24-hour coding challenge with amazing prizes',
          style: TextStyle(fontSize: 12),
        ),
        value: _attendHackathon,
        onChanged: (value) => setState(() => _attendHackathon = value ?? false),
        activeColor: const Color(0xFF4CAF50),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildQRView() {
    if (_registrationData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My QR Code')),
        body: const Center(
          child: Text('No registration found. Please register first.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration QR Code'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _isRegistered = false;
                _nameController.text = _registrationData!['name'];
                _emailController.text = _registrationData!['email'];
                _organizationController.text = _registrationData!['organization'];
                _phoneController.text = _registrationData!['phone'];
                _selectedRole = _registrationData!['role'];
                _attendHackathon = _registrationData!['hackathon'];
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF9C27B0).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your Registration',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn().slideY(begin: -0.2, end: 0),
                const SizedBox(height: 10),
                const Text(
                  'Show this at the registration desk',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF9C27B0).withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: QrImageView(
                          data: json.encode(_registrationData),
                          version: QrVersions.auto,
                          size: 250,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _registrationData!['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _registrationData!['email'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _registrationData!['role'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (_registrationData!['hackathon']) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6584).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFFF6584),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.code, size: 16, color: Color(0xFFFF6584)),
                              SizedBox(width: 6),
                              Text(
                                'Hackathon Participant',
                                style: TextStyle(
                                  color: Color(0xFFFF6584),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Text(
                        'ID: ${_registrationData!['registrationId']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(delay: 200.ms, duration: 500.ms, curve: Curves.easeOut),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Keep this QR code safe. You\'ll need it for check-in and access to event sessions.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _organizationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
