import 'package:flutter/material.dart';

class OrgDetail extends StatelessWidget {
  const OrgDetail({
    required this.detail,
    required this.icon,
    super.key,
  });

  // properties
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(
              icon,
              size: 25,
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Text(
              detail,
              softWrap: true,
              style: const TextStyle(
                fontSize: 19,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
