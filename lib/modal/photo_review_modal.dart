class PhotoReviewItem {
  final String id;
  final String title;
  final String status;
  final String albumLine;
  final int photos;
  final String metaLine;
  final bool pending;

  const PhotoReviewItem({
    required this.id,
    required this.title,
    required this.status,
    required this.albumLine,
    required this.photos,
    required this.metaLine,
    required this.pending,
  });
}
