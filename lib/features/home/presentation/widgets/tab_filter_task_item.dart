import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';
import 'package:interview_junior_flutter/core/themes/bloc/theme_bloc.dart';

class TabFilterTaskItem extends StatelessWidget {
  final String statusTitle;
  final bool isSelected;
  final Function() onTap;

  const TabFilterTaskItem({
    super.key,
    required this.statusTitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (__, state) {
          return Container(
            width: MediaQuery.of(context).size.width / 3.5,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color:
                  isSelected
                      ? AppColors.primary
                      : state.isDarkMode
                      ? Colors.white70
                      : AppColors.primary.withOpacity(.1),
            ),
            child: Text(
              statusTitle,
              style: context.textStyle16.copyWith(
                color: isSelected ? Colors.white : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
