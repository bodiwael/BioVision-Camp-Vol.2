import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFC107).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(),
              const SizedBox(height: 30),
              _buildAboutSection(),
              const SizedBox(height: 30),
              _buildVenueSection(),
              const SizedBox(height: 30),
              _buildDateTimeSection(),
              const SizedBox(height: 30),
              _buildFacilitiesSection(),
              const SizedBox(height: 30),
              _buildContactSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C63FF),
            Color(0xFFFF6584),
            Color(0xFF00D4FF),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '🧬',
            style: TextStyle(fontSize: 70),
          ),
          const SizedBox(height: 16),
          const Text(
            'BioVision Camp Vol.2',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Where Biology Meets Technology',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().scale(duration: 500.ms, curve: Curves.easeOut);
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          const Row(
            children: [
              Icon(Icons.info, color: Color(0xFF6C63FF), size: 28),
              SizedBox(width: 12),
              Text(
                'About the Event',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'BioVision Camp Vol.2 is a premier gathering of biologists, technologists, and innovators passionate about advancing biological research through computational methods and AI.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Join us for two days of inspiring talks, hands-on workshops, and an exciting hackathon where you\'ll collaborate with brilliant minds to solve real-world biological challenges.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildVenueSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          const Row(
            children: [
              Icon(Icons.location_on, color: Color(0xFFFF6584), size: 28),
              SizedBox(width: 12),
              Text(
                'Venue',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('📍', 'BioTech Innovation Center'),
          const SizedBox(height: 12),
          _buildInfoRow('🏙️', '3500 Campus Drive, Silicon Valley, CA 94025'),
          const SizedBox(height: 12),
          _buildInfoRow('🚗', 'Free parking available on-site'),
          const SizedBox(height: 12),
          _buildInfoRow('🚇', 'Accessible via CalTrain & VTA'),
        ],
      ),
    ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildDateTimeSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          const Row(
            children: [
              Icon(Icons.calendar_today, color: Color(0xFF00D4FF), size: 28),
              SizedBox(width: 12),
              Text(
                'Date & Time',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDateCard(
                  'Day 1',
                  'December 20',
                  '9:00 AM - 6:00 PM',
                  const Color(0xFF6C63FF),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateCard(
                  'Day 2',
                  'December 21',
                  '9:00 AM - 6:00 PM',
                  const Color(0xFFFF6584),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildDateCard(String day, String date, String time, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFacilitiesSection() {
    final facilities = [
      {'icon': '☕', 'title': 'Free Coffee & Meals', 'color': const Color(0xFFFFC107)},
      {'icon': '📶', 'title': 'High-Speed WiFi', 'color': const Color(0xFF00D4FF)},
      {'icon': '🎁', 'title': 'Swag & Goodies', 'color': const Color(0xFFFF6584)},
      {'icon': '🏆', 'title': 'Networking Events', 'color': const Color(0xFF6C63FF)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What\'s Included',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          itemCount: facilities.length,
          itemBuilder: (context, index) {
            final facility = facilities[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: (facility['color'] as Color).withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    facility['icon'] as String,
                    style: const TextStyle(fontSize: 36),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    facility['title'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).animate(delay: (100 * index).ms).scale(duration: 400.ms);
          },
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C63FF).withOpacity(0.1),
            const Color(0xFFFF6584).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.contact_mail, color: Color(0xFF6C63FF), size: 28),
              SizedBox(width: 12),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('📧', 'info@biovisioncamp.com'),
          const SizedBox(height: 12),
          _buildInfoRow('📱', '+1 (650) 555-0123'),
          const SizedBox(height: 12),
          _buildInfoRow('🌐', 'www.biovisioncamp.com'),
          const SizedBox(height: 12),
          _buildInfoRow('💬', '@BioVisionCamp on Twitter'),
        ],
      ),
    ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildInfoRow(String emoji, String text) {
    return Row(
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
