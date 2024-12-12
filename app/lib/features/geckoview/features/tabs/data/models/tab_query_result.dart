class TabQueryResult {
  final String title;
  final String url;

  final String? extractedContent;
  final String? fullContent;

  final double weightedRank;

  TabQueryResult({
    required this.title,
    required this.url,
    this.extractedContent,
    this.fullContent,
    required this.weightedRank,
  });
}
