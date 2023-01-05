class Zman {
  Zman(this.title, this.date);

  final String title;
  final DateTime date;

  @override
  String toString() {
    return '${super.toString()} - title: $title, date: ${date.day}/${date.month}/${date.year} ';
  }
}
