import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  // Exchange rates relative to USD (base currency)
  static const Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'EUR': 0.92,
    'PKR': 278.50,
    'GBP': 0.79,
    'AED': 3.67,
    'SAR': 3.75,
  };

  static const Map<String, String> _currencySymbols = {
    'USD': '\$',
    'EUR': '€',
    'PKR': 'Rs',
    'GBP': '£',
    'AED': 'د.إ',
    'SAR': 'ر.س',
  };

  /// Convert amount from USD to target currency
  static double convertFromUSD(double amountInUSD, String targetCurrency) {
    final rate = _exchangeRates[targetCurrency.toUpperCase()] ?? 1.0;
    return amountInUSD * rate;
  }

  /// Convert amount from source currency to USD
  static double convertToUSD(double amount, String sourceCurrency) {
    final rate = _exchangeRates[sourceCurrency.toUpperCase()] ?? 1.0;
    return amount / rate;
  }

  /// Convert amount from source currency to target currency
  static double convert(double amount, String fromCurrency, String toCurrency) {
    final amountInUSD = convertToUSD(amount, fromCurrency);
    return convertFromUSD(amountInUSD, toCurrency);
  }

  /// Format amount with currency symbol
  static String formatAmount(double amount, String currency, {int decimals = 0}) {
    final symbol = _currencySymbols[currency.toUpperCase()] ?? currency;
    final formatted = amount.toStringAsFixed(decimals);

    // Format with commas for thousands
    final parts = formatted.split('.');
    final intPart = parts[0];
    final decPart = parts.length > 1 ? '.${parts[1]}' : '';

    final formattedInt = intPart.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    return '$symbol$formattedInt$decPart';
  }

  /// Get currency symbol
  static String getSymbol(String currency) {
    return _currencySymbols[currency.toUpperCase()] ?? currency;
  }

  /// Get all supported currencies
  static List<String> getSupportedCurrencies() {
    return _exchangeRates.keys.toList();
  }

  /// Fetch live exchange rates (optional - for future enhancement)
  static Future<Map<String, double>> fetchLiveRates() async {
    try {
      // You can integrate with a real API like exchangerate-api.com
      // For now, return static rates
      return _exchangeRates;
    } catch (e) {
      return _exchangeRates;
    }
  }
}
