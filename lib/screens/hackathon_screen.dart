import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HackathonScreen extends StatelessWidget {
  const HackathonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BioVision Hackathon'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF00D4FF).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildPrizeSection(),
              const SizedBox(height: 30),
              _buildThemes(),
              const SizedBox(height: 30),
              _buildRules(),
              const SizedBox(height: 30),
              _buildTimeline(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00D4FF), Color(0xFF6C63FF)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '💻',
            style: TextStyle(fontSize: 60),
          ),
          const SizedBox(height: 16),
          const Text(
            'Build the Future of Biology',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '24 Hours of Innovation',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 500.ms, curve: Curves.easeOut);
  }

  Widget _buildPrizeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🏆 Prizes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildPrizeCard(
                '1st Place',
                '\$10,000',
                const Color(0xFFFFD700),
                '🥇',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPrizeCard(
                '2nd Place',
                '\$5,000',
                const Color(0xFFC0C0C0),
                '🥈',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildPrizeCard(
                '3rd Place',
                '\$2,500',
                const Color(0xFFCD7F32),
                '🥉',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildPrizeCard(
                'Best AI',
                '\$1,000',
                const Color(0xFF6C63FF),
                '🤖',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrizeCard(String title, String prize, Color color, String emoji) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            prize,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).animate().scale(delay: 200.ms, duration: 400.ms);
  }

  Widget _buildThemes() {
    final themes = [
      {
        'icon': '🧬',
        'title': 'Gene Editing Tools',
        'desc': 'Build tools for CRISPR analysis',
        'color': const Color(0xFF6C63FF),
      },
      {
        'icon': '🤖',
        'title': 'AI Diagnostics',
        'desc': 'Machine learning for disease detection',
        'color': const Color(0xFFFF6584),
      },
      {
        'icon': '📊',
        'title': 'Data Visualization',
        'desc': 'Interactive genomic data dashboards',
        'color': const Color(0xFF00D4FF),
      },
      {
        'icon': '💊',
        'title': 'Drug Discovery',
        'desc': 'Computational drug design platforms',
        'color': const Color(0xFF4CAF50),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🎯 Challenge Themes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...themes.asMap().entries.map((entry) {
          final index = entry.key;
          final theme = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (theme['color'] as Color).withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: (theme['color'] as Color).withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (theme['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        theme['icon'] as String,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          theme['title'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          theme['desc'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate(delay: (100 * index).ms).fadeIn().slideX(begin: -0.2, end: 0),
          );
        }),
      ],
    );
  }

  Widget _buildRules() {
    final rules = [
      'Teams of 2-5 members',
      'All code must be original',
      'Use of APIs and libraries is allowed',
      'Must include a demo video',
      'Open source submission preferred',
    ];

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
          const Row(
            children: [
              Icon(Icons.rule, color: Color(0xFFFF6584)),
              SizedBox(width: 8),
              Text(
                'Rules & Guidelines',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...rules.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF4CAF50),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildTimeline() {
    final timeline = [
      {'time': '3:30 PM', 'event': 'Hackathon Kickoff'},
      {'time': '4:00 PM', 'event': 'Team Formation'},
      {'time': '5:00 PM', 'event': 'Hacking Begins'},
      {'time': '9:00 PM', 'event': 'Dinner & Networking'},
      {'time': '12:00 AM', 'event': 'Midnight Snacks'},
      {'time': '9:00 AM', 'event': 'Breakfast'},
      {'time': '3:00 PM', 'event': 'Submissions Due'},
      {'time': '4:00 PM', 'event': 'Presentations'},
      {'time': '6:00 PM', 'event': 'Winners Announced'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
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
              Icon(Icons.schedule, color: Color(0xFF6C63FF)),
              SizedBox(width: 8),
              Text(
                'Hackathon Timeline',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...timeline.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['time']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item['event']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2, end: 0);
  }
}
