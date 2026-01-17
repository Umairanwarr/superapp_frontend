import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:superapp/screens/booking_confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF2FC1BE),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Payment',
                      style: TextStyle(
                        color: Color(0xFF2FC1BE),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Total Amount Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF38CAC7),
                        Color(0xFF27B9B6),
                        Color(0xFF119C99),
                      ],
                      stops: [0.02, 0.49, 1.0],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2FC1BE).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Total amount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\$1774',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Including taxes and fees',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 10,
                        child: SvgPicture.asset(
                          'assets/wallet.svg',
                          width: 80,
                          height: 80,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Payment Methods Tabs
                Row(
                  children: [
                    _PaymentTab(
                      text: 'Card',
                      isSelected: _selectedMethod == 'Card',
                      onTap: () => setState(() => _selectedMethod = 'Card'),
                    ),
                    const SizedBox(width: 12),
                    _PaymentTab(
                      text: 'Wallet',
                      isSelected: _selectedMethod == 'Wallet',
                      onTap: () => setState(() => _selectedMethod = 'Wallet'),
                    ),
                    const SizedBox(width: 12),
                    _PaymentTab(
                      text: 'Apple pay',
                      isSelected: _selectedMethod == 'Apple pay',
                      onTap: () =>
                          setState(() => _selectedMethod = 'Apple pay'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Conditional Content based on selected payment method
                if (_selectedMethod == 'Card') ...[
                  // Card Details Form
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/ion_card-outline.svg',
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFF2FC1BE),
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Card Details',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D2330),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _LabelInfo('Card Number'),
                        const SizedBox(height: 8),
                        _PaymentTextField(hint: '1234 5678 9012 3456'),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  _LabelInfo('Expiry Date'),
                                  SizedBox(height: 8),
                                  _PaymentTextField(hint: 'MM/YY'),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  _LabelInfo('CVV'),
                                  SizedBox(height: 8),
                                  _PaymentTextField(hint: '123'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _LabelInfo('Cardholder Name'),
                        const SizedBox(height: 8),
                        _PaymentTextField(hint: ''),
                        const SizedBox(height: 24),
                        Center(
                          child: SizedBox(
                            height: 40,
                            width: 140,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2FC1BE),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Save Card',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Saved Cards
                  const Text(
                    'Saved Cards',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D2330),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2FC1BE),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SvgPicture.asset(
                            'assets/ion_card-outline.svg',
                            width: 28,
                            height: 28,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '.... .... .... 4242',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D2330),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Expires 12/25',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF878787),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ] else if (_selectedMethod == 'Wallet') ...[
                  // Wallet Balance Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC9FACF).withOpacity(0.44),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF22C55E),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: SvgPicture.asset(
                                'assets/uit_wallet.svg',
                                width: 28,
                                height: 28,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Wallet Balance',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                Text(
                                  '\$2950.00',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF22C55E),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'You have sufficient balance to complete this booking.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF5A606A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Remaining Balance Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Remaining balance after payment:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1D2330),
                          ),
                        ),
                        Text(
                          '\$1176',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2FC1BE),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ] else ...[
                  // Apple Pay Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.apple, size: 50, color: Colors.black),
                            SizedBox(width: 4),
                            Text(
                              'Pay',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Fast and secure payment with Apple Pay',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF1D2330),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => const BookingConfirmationScreen());
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.apple,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Pay with Apple Pay',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Secure Payment
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white, // In image it looks white.
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE0E0E0).withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          Icons.lock_outline,
                          color: const Color(0xFF2FC1BE),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Secure Payment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D2330),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Your payment information is encrypted and secure. We never store your full card details.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF9CA3AF),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Terms text
                RichText(
                  textAlign: TextAlign.start,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1D2330),
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(
                        text: 'By completing this booking, you agree to the ',
                      ),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(color: Color(0xFF2FC1BE)),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Cancellation Policy.',
                        style: TextStyle(color: Color(0xFF2FC1BE)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Pay Button (hidden for Apple Pay)
                if (_selectedMethod != 'Apple pay')
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const BookingConfirmationScreen());
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2FC1BE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.lock_outline,
                            size: 18,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Pay \$1774',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentTab({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF28C2C0)
                : const Color(0xFFFBF4F4),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
              if (isSelected)
                BoxShadow(
                  color: const Color(0xFF28C2C0).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF28C2C0),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LabelInfo extends StatelessWidget {
  final String text;
  const _LabelInfo(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1D2330),
      ),
    );
  }
}

class _PaymentTextField extends StatelessWidget {
  final String hint;
  const _PaymentTextField({required this.hint});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFFBDBDBD),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF1D2330),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
