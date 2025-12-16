import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import 'agenda_screen.dart';
import 'speakers_screen.dart';
import 'hackathon_screen.dart';
import 'event_details_screen.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = await AuthService.getCurrentUser();
    setState(() {
      _currentUser = user;
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await AuthService.logout();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${_currentUser?.name.split(' ').first ?? 'User'}!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF6C63FF).withOpacity(0.1),
              const Color(0xFFFF6584).withOpacity(0.1),
              const Color(0xFF00D4FF).withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildMenuGrid(context),
                  const SizedBox(height: 30),
                  _buildQuickInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🧬',
          style: TextStyle(fontSize: 60),
        ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
        const SizedBox(height: 10),
        const Text(
          'BioVision Camp',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6C63FF),
          ),
        ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0),
        const Text(
          'Volume 2',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w300,
            color: Color(0xFFFF6584),
          ),
        ).animate(delay: 200.ms).fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'December 20-21, 2025',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ).animate(delay: 400.ms).scale(duration: 400.ms, curve: Curves.easeOut),
      ],
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    final menuItems = [
      MenuItemData(
        title: 'Agenda',
        icon: Icons.schedule,
        color: const Color(0xFF6C63FF),
        gradient: [const Color(0xFF6C63FF), const Color(0xFF9C8FFF)],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AgendaScreen()),
        ),
      ),
      MenuItemData(
        title: 'Speakers',
        icon: Icons.people,
        color: const Color(0xFFFF6584),
        gradient: [const Color(0xFFFF6584), const Color(0xFFFF9AA2)],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SpeakersScreen()),
        ),
      ),
      MenuItemData(
        title: 'Hackathon',
        icon: Icons.code,
        color: const Color(0xFF00D4FF),
        gradient: [const Color(0xFF00D4FF), const Color(0xFF5DE8FF)],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HackathonScreen()),
        ),
      ),
      MenuItemData(
        title: 'Event Info',
        icon: Icons.info,
        color: const Color(0xFFFFC107),
        gradient: [const Color(0xFFFFC107), const Color(0xFFFFD54F)],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventDetailsScreen()),
        ),
      ),
      MenuItemData(
        title: 'Register',
        icon: Icons.app_registration,
        color: const Color(0xFF4CAF50),
        gradient: [const Color(0xFF4CAF50), const Color(0xFF81C784)],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
        ),
      ),
      MenuItemData(
        title: 'My QR Code',
        icon: Icons.qr_code,
        color: const Color(0xFF9C27B0),
        gradient: [const Color(0xFF9C27B0), const Color(0xFFBA68C8)],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegistrationScreen(showQR: true)),
        ),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return _buildMenuItem(menuItems[index], index);
      },
    );
  }

  Widget _buildMenuItem(MenuItemData item, int index) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: item.gradient,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: (100 * index).ms)
        .scale(duration: 400.ms, curve: Curves.easeOut)
        .fadeIn(duration: 400.ms);
  }

  Widget _buildQuickInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFFFF6584)),
              const SizedBox(width: 8),
              const Text(
                'Venue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'BioTech Innovation Center\nSilicon Valley, CA',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.timer, color: Color(0xFF6C63FF)),
              const SizedBox(width: 8),
              const Text(
                'Duration',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '2 Days of Innovation\n9:00 AM - 6:00 PM',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ).animate(delay: 600.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0);
  }
}

class MenuItemData {
  final String title;
  final IconData icon;
  final Color color;
  final List<Color> gradient;
  final VoidCallback onTap;

  MenuItemData({
    required this.title,
    required this.icon,
    required this.color,
    required this.gradient,
    required this.onTap,
  });
}
