import 'package:flutter/material.dart';

class ConectionsWidget extends StatelessWidget {
  const ConectionsWidget({super.key, required this.link});
  final String link;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Website',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(
              avatar: Icon(Icons.web, color: Colors.white, size: 16),
              label: Text(
                link,
                style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline),
              ),
              backgroundColor: Colors.grey[700],
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
