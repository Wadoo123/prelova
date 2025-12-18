import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const SectionTitle({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: const Text(
                'Lihat semua',
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
