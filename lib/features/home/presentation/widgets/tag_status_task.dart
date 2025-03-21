import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';

class TagDeliveryMethod extends StatelessWidget {
  final String title;
  final int methodDelivery;

  const TagDeliveryMethod({
    super.key,
    required this.title,
    required this.methodDelivery,
  });

  Color getColorByMethodDelivery(int status) {
    switch (status) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.blue;
      default:
        throw ArgumentError("Invalid value for status: $status");
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = getColorByMethodDelivery(methodDelivery);
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: mainColor.withOpacity(.6),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: mainColor, width: 0.5),
      ),
      child: Text(
        title,
        style: TextStyle(color: AppColors.contentColorWhite, fontSize: 10),
      ),
    );
  }
}
