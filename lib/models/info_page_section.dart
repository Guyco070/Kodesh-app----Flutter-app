/// A titled block of text on an informational page (about, accessibility
/// statement, privacy policy).
class InfoPageSection {
  const InfoPageSection({this.title, required this.paragraphs});

  final String? title;
  final List<String> paragraphs;
}
