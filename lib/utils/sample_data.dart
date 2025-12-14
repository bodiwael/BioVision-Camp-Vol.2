import '../models/speaker.dart';
import '../models/agenda_item.dart';

class SampleData {
  static List<Speaker> getSpeakers() {
    return [
      Speaker(
        name: 'Dr. Sarah Chen',
        title: 'Chief Scientific Officer',
        company: 'BioTech Innovations',
        bio: 'Leading expert in computational biology and AI-driven drug discovery with 15+ years of experience.',
        imageUrl: '👩‍🔬',
        topic: 'AI in Modern Biology',
      ),
      Speaker(
        name: 'Prof. Michael Rodriguez',
        title: 'Professor of Genomics',
        company: 'MIT',
        bio: 'Pioneering researcher in gene editing and CRISPR technology applications.',
        imageUrl: '👨‍🔬',
        topic: 'CRISPR Revolution',
      ),
      Speaker(
        name: 'Dr. Aisha Patel',
        title: 'Director of Research',
        company: 'HealthGen Labs',
        bio: 'Specialist in personalized medicine and biomarker discovery.',
        imageUrl: '👩‍⚕️',
        topic: 'Personalized Medicine',
      ),
      Speaker(
        name: 'James Thompson',
        title: 'Tech Lead',
        company: 'BioVision AI',
        bio: 'Building scalable bioinformatics platforms for next-gen sequencing analysis.',
        imageUrl: '👨‍💻',
        topic: 'Bioinformatics Tools',
      ),
    ];
  }

  static List<AgendaItem> getAgenda() {
    return [
      AgendaItem(
        time: '09:00 AM',
        title: 'Registration & Welcome Coffee',
        description: 'Check-in and networking session',
        type: 'break',
      ),
      AgendaItem(
        time: '10:00 AM',
        title: 'Opening Keynote',
        description: 'The Future of Biological Computing',
        speaker: 'Dr. Sarah Chen',
        type: 'session',
      ),
      AgendaItem(
        time: '11:00 AM',
        title: 'CRISPR & Gene Editing',
        description: 'Latest advances in genome editing technology',
        speaker: 'Prof. Michael Rodriguez',
        type: 'session',
      ),
      AgendaItem(
        time: '12:00 PM',
        title: 'Lunch Break',
        description: 'Networking lunch and poster sessions',
        type: 'break',
      ),
      AgendaItem(
        time: '01:30 PM',
        title: 'Workshop: Bioinformatics Tools',
        description: 'Hands-on session with modern bioinformatics platforms',
        speaker: 'James Thompson',
        type: 'workshop',
      ),
      AgendaItem(
        time: '03:00 PM',
        title: 'Coffee Break',
        description: 'Refreshments and networking',
        type: 'break',
      ),
      AgendaItem(
        time: '03:30 PM',
        title: 'Hackathon Launch',
        description: 'BioVision Hackathon kickoff and team formation',
        type: 'hackathon',
      ),
      AgendaItem(
        time: '04:00 PM',
        title: 'Personalized Medicine Panel',
        description: 'Discussion on the future of precision healthcare',
        speaker: 'Dr. Aisha Patel',
        type: 'session',
      ),
      AgendaItem(
        time: '05:30 PM',
        title: 'Closing Remarks',
        description: 'Day wrap-up and hackathon guidelines',
        type: 'session',
      ),
    ];
  }
}
