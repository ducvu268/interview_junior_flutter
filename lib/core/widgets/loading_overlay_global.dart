import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/widgets/loading_indicator.dart';

class LoadingOverlayGlobal extends StatelessWidget {
  const LoadingOverlayGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.black.withOpacity(.4),
        child: const Center(child: LoadingIndicator()),
      ),
    );
  }
}
