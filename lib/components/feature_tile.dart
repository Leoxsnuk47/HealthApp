import 'package:flutter/material.dart';

class FeatureTile extends StatelessWidget {
  const FeatureTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0, // Specify a height for the container
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('lib/images/mic.png'),
          const Text('Audio Recording'),
        ],
      ),
    );
  }
}
