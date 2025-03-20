import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/widgets/loading_indicator.dart';

class LoadingScreenGlobal extends StatelessWidget {
  const LoadingScreenGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const Center(child: LoadingIndicator()),
    );
  }
}
