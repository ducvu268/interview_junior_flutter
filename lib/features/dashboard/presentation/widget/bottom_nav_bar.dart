import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';
import 'package:interview_junior_flutter/core/themes/bloc/theme_bloc.dart';

class BottomNavBar extends StatelessWidget {
  final int activeIndex;
  final Function(int i) onTap;

  const BottomNavBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = <IconData>[Icons.home, Icons.person];
    List<String> labels = <String>['Home', 'Home'];

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (__, state) {
        return SizedBox(
          width: double.maxFinite,
          child: AnimatedBottomNavigationBar.builder(
            itemCount: icons.length,
            tabBuilder: (int index, bool isActive) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons[index],
                    size: 30,
                    color: isActive ? AppColors.primary : Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AutoSizeText(
                      labels[index],
                      maxLines: 1,
                      style: context.textStyle12.copyWith(
                        color: isActive ? AppColors.primary : Colors.grey,
                      ),
                    ),
                  )
                ],
              );
            },
            scaleFactor: 0,
            activeIndex: activeIndex,
            elevation: 12,
            shadow: Shadow(
              color: Colors.grey.withOpacity(0.8),
              blurRadius: 10,
              offset: const Offset(3, 1),
            ),
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.defaultEdge,
            blurEffect: false,
            backgroundColor: Colors.white,
            leftCornerRadius: 0,
            rightCornerRadius: 0,
            height: 62,
            onTap: onTap,
          ),
        );
      },
    );
  }
}
