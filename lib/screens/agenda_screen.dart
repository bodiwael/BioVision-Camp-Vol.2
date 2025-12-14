import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/agenda_item.dart';
import '../utils/sample_data.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final agendaItems = SampleData.getAgenda();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Agenda'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF6C63FF).withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: agendaItems.length,
          itemBuilder: (context, index) {
            return _buildAgendaItem(agendaItems[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildAgendaItem(AgendaItem item, int index) {
    Color itemColor;
    IconData itemIcon;

    switch (item.type) {
      case 'session':
        itemColor = const Color(0xFF6C63FF);
        itemIcon = Icons.presentation_chart;
        break;
      case 'workshop':
        itemColor = const Color(0xFF00D4FF);
        itemIcon = Icons.construction;
        break;
      case 'hackathon':
        itemColor = const Color(0xFFFF6584);
        itemIcon = Icons.code;
        break;
      case 'break':
        itemColor = const Color(0xFFFFC107);
        itemIcon = Icons.coffee;
        break;
      default:
        itemColor = Colors.grey;
        itemIcon = Icons.event;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: itemColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: itemColor, width: 2),
                ),
                child: Icon(
                  itemIcon,
                  color: itemColor,
                  size: 28,
                ),
              ),
              if (index < SampleData.getAgenda().length - 1)
                Container(
                  width: 2,
                  height: 80,
                  color: itemColor.withOpacity(0.3),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: itemColor.withOpacity(0.2),
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
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: itemColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.time,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.type.toUpperCase(),
                          style: TextStyle(
                            color: itemColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (item.speaker != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: itemColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.speaker!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: itemColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      )
          .animate(delay: (50 * index).ms)
          .fadeIn(duration: 400.ms)
          .slideX(begin: 0.2, end: 0),
    );
  }
}
