import 'package:flutter/material.dart';

class QrCodeCard extends StatelessWidget {
  final VoidCallback? onDownload;
  final VoidCallback? onShare;

  const QrCodeCard({super.key, this.onDownload, this.onShare});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2FC1BE).withOpacity(0.35)),
      ),

      child: Column(
        children: [
          // QR Code with background
          Container(
            width: 180,
            height: 180,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8F7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF2FC1BE).withOpacity(0.3),
              ),
            ),
            child: CustomPaint(
              size: const Size(140, 140),
              painter: _QrCodePainter(),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            'Your Check-in QR Code',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2330),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Show this code at the hotel reception',
            style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ActionButton(
                icon: Icons.download,
                label: 'Download',
                onTap: onDownload,
              ),
              const SizedBox(width: 16),
              _ActionButton(icon: Icons.share, label: 'Share', onTap: onShare),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),

        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF1D2330)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1D2330),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QrCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2FC1BE)
      ..style = PaintingStyle.fill;

    final borderRadius = 8.0;
    final cellSize = size.width / 7;

    // Draw QR-like pattern
    final pattern = [
      [1, 1, 1, 0, 1, 1, 1],
      [1, 0, 1, 0, 1, 0, 1],
      [1, 1, 1, 0, 1, 1, 1],
      [0, 0, 0, 0, 0, 0, 0],
      [1, 1, 1, 0, 1, 0, 0],
      [1, 0, 0, 0, 0, 1, 0],
      [1, 0, 1, 0, 1, 1, 1],
    ];

    for (int row = 0; row < pattern.length; row++) {
      for (int col = 0; col < pattern[row].length; col++) {
        if (pattern[row][col] == 1) {
          final rect = RRect.fromRectAndRadius(
            Rect.fromLTWH(
              col * cellSize + 2,
              row * cellSize + 2,
              cellSize - 4,
              cellSize - 4,
            ),
            Radius.circular(borderRadius),
          );
          canvas.drawRRect(rect, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
