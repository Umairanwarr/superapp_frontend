import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:superapp/controllers/my_wallet_controllr.dart';
import 'package:superapp/modal/my_wallet_modal.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(MyWalletController());
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    onPressed: c.back,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: primary,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    "My Wallet",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Top Card
              Obx(
                () => _WalletTopCard(
                  theme: theme,
                  total: c.balanceFormatted,
                  deltaText: c.deltaText,
                ),
              ),

              const SizedBox(height: 14),

              // Actions Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ActionTile(
                    icon: Icons.add_rounded,
                    label: "Top Up",
                    onTap: c.onTopUp,
                    primary: primary,
                  ),
                  _ActionTile(
                    icon: Icons.download_rounded,
                    label: "Withdraw",
                    onTap: c.onWithdraw,
                    primary: primary,
                  ),
                  _ActionTile(
                    icon: Icons.qr_code_scanner_rounded,
                    label: "Scan",
                    onTap: c.onScan,
                    primary: primary,
                  ),
                  _ActionTile(
                    icon: Icons.grid_view_rounded,
                    label: "More",
                    onTap: c.onMore,
                    primary: primary,
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Info Card
              _InfoCard(primary: primary, theme: theme),

              const SizedBox(height: 18),

              // Recent Transactions header
              Row(
                children: [
                  Text(
                    "Recent Transactions",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: const Color(0xFF1D2330),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: c.onSeeAll,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "See All",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Transactions List
              Obx(
                () => _Card(
                  child: Column(
                    children: [
                      for (int i = 0; i < c.txns.length; i++) ...[
                        _TxnTile(txn: c.txns[i], primary: primary),
                        if (i != c.txns.length - 1)
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFF2F2F2),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- UI Widgets ---------------- */

class _WalletTopCard extends StatelessWidget {
  const _WalletTopCard({
    required this.theme,
    required this.total,
    required this.deltaText,
  });

  final ThemeData theme;
  final String total;
  final String deltaText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF38CAC7), Color(0xFF27B9B6), Color(0xFF119C99)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Total Expenses (This Month)",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.white.withOpacity(0.92),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.copy_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            total,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Spacer(),
          Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.center,
            child: Text(
              deltaText,
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.primary,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 74,
        child: Column(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 14,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 20, color: primary),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: const Color(0xFF1D2330),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.primary, required this.theme});

  final Color primary;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.auto_awesome_rounded, size: 18, color: primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ready for your next trip?",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: const Color(0xFF1D2330),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Use your wallet balance to book hotels instantly without fees.",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: const Color(0xFF9AA0AF),
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TxnTile extends StatelessWidget {
  const _TxnTile({required this.txn, required this.primary});

  final MyWalletModal txn;
  final Color primary;

  IconData _iconFromType(int t) {
    switch (t) {
      case 0:
        return Icons.hotel_outlined;
      case 1:
        return Icons.trending_up_rounded;
      case 2:
        return Icons.currency_exchange_rounded;
      default:
        return Icons.receipt_long_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isPositive = txn.amount >= 0;
    final amountColor = isPositive
        ? const Color(0xFF22C55E)
        : const Color(0xFF1D2330);
    final amountText =
        "${isPositive ? "+" : "-"} \$${txn.amount.abs().toStringAsFixed(2)}";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(_iconFromType(txn.iconType), size: 18, color: primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF1D2330),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  txn.meta,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF9AA0AF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amountText,
            style: theme.textTheme.titleSmall?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
