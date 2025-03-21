import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final bool isLoading;
  final Function() onDelete;

  const ConfirmDeleteDialog({
    super.key,
    required this.isLoading,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 36,
      ).copyWith(top: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Are you sure you want to delete this task ?',
            style: context.textStyle18.copyWith(
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
              color: AppColors.contentColorBlack,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: isLoading ? () {} : () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.grey.shade100,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  fixedSize: Size.fromWidth(
                    MediaQuery.of(context).size.width * 0.45,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: context.textStyle14.copyWith(
                      color: const Color(0xFF606060),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: isLoading ? () {} : onDelete,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor:
                      isLoading
                          ? const Color(0xFFFF5C5C).withOpacity(.3)
                          : const Color(0xFFFF5C5C),
                  surfaceTintColor: Colors.transparent,
                  fixedSize: Size.fromWidth(
                    MediaQuery.of(context).size.width * 0.45,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Delete',
                  style: context.textStyle14.copyWith(
                    color: AppColors.contentColorWhite,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
