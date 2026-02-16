enum AiMessageType { text, hotelList, chart }

class AiHotel {
  final int id;
  final String name;
  final String location;
  final double price;
  final String image;
  final String match;

  AiHotel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.image,
    required this.match,
  });

  factory AiHotel.fromJson(Map<String, dynamic> json) {
    return AiHotel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'] ?? '',
      match: json['match'] ?? '',
    );
  }
}

class AiChartData {
  final double currentPrice;
  final double bestPrice;
  final int confidence;
  final List<Map<String, dynamic>> points; // {x: 0, y: 100}
  final List<String> xLabels;

  AiChartData({
    required this.currentPrice,
    required this.bestPrice,
    required this.confidence,
    required this.points,
    required this.xLabels,
  });

  factory AiChartData.fromJson(Map<String, dynamic> json) {
    return AiChartData(
      currentPrice: (json['currentPrice'] ?? 0).toDouble(),
      bestPrice: (json['bestPrice'] ?? 0).toDouble(),
      confidence: json['confidence'] ?? 0,
      points: List<Map<String, dynamic>>.from(json['points'] ?? []),
      xLabels: List<String>.from(json['xLabels'] ?? []),
    );
  }
}

class AiChatMessage {
  final AiMessageType type;
  final String? text;
  final List<AiHotel>? hotels;
  final AiChartData? chartData;
  final bool isUser;

  AiChatMessage({
    required this.type,
    this.text,
    this.hotels,
    this.chartData,
    this.isUser = false,
  });
}
