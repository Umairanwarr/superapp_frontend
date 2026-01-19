class HotelModal {
  final String name;
  final String location;
  final double rating;
  final String? price;
  final String? tag;

  const HotelModal({
    required this.name,
    required this.location,
    required this.rating,
    this.price,
    this.tag,
  });
}
