import 'package:get/get.dart';
import 'package:superapp/controllers/profile_controller.dart';
import 'package:superapp/services/listing_service.dart';
import 'package:superapp/services/currency_service.dart';

class MyListingController extends GetxController {
  final _listingService = ListingService();

  // ─── Hotels ─────────────────────────────────────────────
  final hotels = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final selectedTab = 0.obs; // 0 = All, 1 = Active, 2 = Inactive

  // ─── Properties ─────────────────────────────────────────
  final properties = <Map<String, dynamic>>[].obs;
  final isLoadingProperties = false.obs;
  final errorMessageProperties = ''.obs;
  final selectedPropertyTab = 0.obs; // 0 = All, 1 = Active, 2 = Inactive

  String get _token {
    try {
      final profile = Get.find<ProfileController>();
      return profile.token;
    } catch (_) {
      return '';
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyHotels();
    fetchMyProperties();
  }

  // ════════════════════════════════════════════════════════
  // HOTELS
  // ════════════════════════════════════════════════════════

  /// Returns filtered hotels based on the selected tab.
  List<Map<String, dynamic>> get filteredHotels {
    if (selectedTab.value == 1) {
      return hotels.where((h) => h['isActive'] == true).toList();
    } else if (selectedTab.value == 2) {
      return hotels.where((h) => h['isActive'] == false).toList();
    }
    return hotels.toList();
  }

  Future<void> fetchMyHotels() async {
    if (_token.trim().isEmpty) {
      errorMessage.value = 'Not authenticated';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _listingService.getMyHotels(_token);
      hotels.value = result.cast<Map<String, dynamic>>();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteHotel(int hotelId) async {
    try {
      await _listingService.deleteHotel(token: _token, hotelId: hotelId);
      hotels.removeWhere((h) => h['id'] == hotelId);
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete hotel: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> toggleHotelStatus(int hotelId, bool newStatus) async {
    try {
      await _listingService.toggleHotelStatus(
        token: _token,
        hotelId: hotelId,
        isActive: newStatus,
      );
      final index = hotels.indexWhere((h) => h['id'] == hotelId);
      if (index != -1) {
        hotels[index] = {...hotels[index], 'isActive': newStatus};
        hotels.refresh();
      }
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update hotel status: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  /// Derive the cheapest room price for display on the listing card.
  String getMinPrice(Map<String, dynamic> hotel) {
    final rooms = hotel['rooms'] as List<dynamic>?;
    if (rooms == null || rooms.isEmpty) return 'N/A';

    double minPrice = double.infinity;
    for (final room in rooms) {
      final price = double.tryParse(room['price'].toString()) ?? 0;
      if (price > 0 && price < minPrice) minPrice = price;
    }
    if (minPrice == double.infinity) return 'N/A';

    // Get user's selected currency
    final profileController = Get.find<ProfileController>();
    final userCurrency = profileController.userCurrency.value;

    // Convert from USD to user's currency
    final convertedPrice = CurrencyService.convertFromUSD(minPrice, userCurrency);

    return CurrencyService.formatAmount(convertedPrice, userCurrency, decimals: 0);
  }

  /// Get the image URL for a hotel – use the proxy endpoint.
  String? getHotelImageUrl(Map<String, dynamic> hotel, {int index = 0}) {
    final images = hotel['images'] as List<dynamic>?;
    if (images == null || images.isEmpty) return null;
    final hotelId = hotel['id'] as int;
    return ListingService.hotelImageUrl(hotelId, index);
  }

  // Legacy alias
  String? getImageUrl(Map<String, dynamic> hotel, {int index = 0}) =>
      getHotelImageUrl(hotel, index: index);

  // ════════════════════════════════════════════════════════
  // PROPERTIES
  // ════════════════════════════════════════════════════════

  /// Returns filtered properties based on the selected tab.
  List<Map<String, dynamic>> get filteredProperties {
    if (selectedPropertyTab.value == 1) {
      return properties.where((p) => p['isActive'] == true).toList();
    } else if (selectedPropertyTab.value == 2) {
      return properties.where((p) => p['isActive'] == false).toList();
    }
    return properties.toList();
  }

  Future<void> fetchMyProperties() async {
    if (_token.trim().isEmpty) {
      errorMessageProperties.value = 'Not authenticated';
      return;
    }

    isLoadingProperties.value = true;
    errorMessageProperties.value = '';

    try {
      final result = await _listingService.getMyProperties(_token);
      properties.value = result.cast<Map<String, dynamic>>();
    } catch (e) {
      errorMessageProperties.value = e.toString();
    } finally {
      isLoadingProperties.value = false;
    }
  }

  Future<bool> deleteProperty(int propertyId) async {
    try {
      await _listingService.deleteProperty(
        token: _token,
        propertyId: propertyId,
      );
      properties.removeWhere((p) => p['id'] == propertyId);
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete property: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> togglePropertyStatus(int propertyId, bool newStatus) async {
    try {
      await _listingService.togglePropertyStatus(
        token: _token,
        propertyId: propertyId,
        isActive: newStatus,
      );
      final index = properties.indexWhere((p) => p['id'] == propertyId);
      if (index != -1) {
        properties[index] = {...properties[index], 'isActive': newStatus};
        properties.refresh();
      }
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update property status: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  /// Get property price for display.
  String getPropertyPrice(Map<String, dynamic> property) {
    final price = double.tryParse(property['price']?.toString() ?? '');
    if (price == null || price == 0) return 'N/A';

    // Get user's selected currency
    final profileController = Get.find<ProfileController>();
    final userCurrency = profileController.userCurrency.value;

    // Convert from USD to user's currency
    final convertedPrice = CurrencyService.convertFromUSD(price, userCurrency);

    if (convertedPrice >= 1000000) {
      return CurrencyService.formatAmount(convertedPrice / 1000000, userCurrency, decimals: 1) + 'M';
    } else if (convertedPrice >= 1000) {
      return CurrencyService.formatAmount(convertedPrice / 1000, userCurrency, decimals: 0) + 'K';
    }
    return CurrencyService.formatAmount(convertedPrice, userCurrency, decimals: 0);
  }

  /// Get the image URL for a property – use the proxy endpoint.
  String? getPropertyImageUrl(Map<String, dynamic> property, {int index = 0}) {
    final images = property['images'] as List<dynamic>?;
    if (images == null || images.isEmpty) return null;
    final propertyId = property['id'] as int;
    return ListingService.propertyImageUrl(propertyId, index);
  }
}
