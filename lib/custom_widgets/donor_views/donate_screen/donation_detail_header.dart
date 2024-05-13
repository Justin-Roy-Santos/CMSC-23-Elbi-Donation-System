import 'package:flutter/material.dart';

class DonationDetailHeader extends StatelessWidget {
  const DonationDetailHeader({required this.text, super.key});

  // property
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          // add solid border to bottom side only
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2, color: Colors.black),
            ),
          ),
          child: Text(
            text,
            softWrap: true,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
