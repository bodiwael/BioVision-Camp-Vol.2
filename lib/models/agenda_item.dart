class AgendaItem {
  final String time;
  final String title;
  final String description;
  final String? speaker;
  final String type; // session, break, workshop, hackathon

  AgendaItem({
    required this.time,
    required this.title,
    required this.description,
    this.speaker,
    required this.type,
  });
}
