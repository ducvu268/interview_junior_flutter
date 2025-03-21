import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarGlobal extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime currentDay;
  final DateTime? firstDay;
  final DateTime lastDay;
  final Function()? onCancel;
  final Function()? onSubmit;
  final Function(DateTime, DateTime)? onDaySelected;
  final bool Function(DateTime)? onSelectedDayPredicate;

  const CalendarGlobal({
    super.key,
    required this.focusedDay,
    required this.currentDay,
    this.firstDay,
    required this.lastDay,
    required this.onCancel,
    required this.onSubmit,
    required this.onDaySelected,
    required this.onSelectedDayPredicate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(4, 4),
            blurRadius: 4.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TableCalendar(
            onDaySelected: onDaySelected,
            focusedDay: focusedDay,
            currentDay: currentDay,
            selectedDayPredicate: onSelectedDayPredicate,
            firstDay: firstDay ?? DateTime.utc(2010, 10, 16),
            lastDay: lastDay,
            headerStyle: HeaderStyle(
              titleTextStyle: context.textStyle16.copyWith(
                fontWeight: FontWeight.w600,
              ),
              leftChevronIcon: Icon(Icons.chevron_left),
              rightChevronIcon: Icon(Icons.chevron_right),
              titleCentered: true,
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: context.textStyle14.copyWith(
                fontWeight: FontWeight.w500,
              ),
              weekendStyle: context.textStyle14.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.primary),
                shape: BoxShape.circle,
              ),
              todayTextStyle: context.textStyle14.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: context.textStyle14.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              defaultTextStyle: context.textStyle14.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              weekendTextStyle: context.textStyle14.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              outsideTextStyle: context.textStyle14.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.6),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),

          /// ACTION
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: onCancel,
                child: Text(
                  'Cancel',
                  style: context.textStyle14.copyWith(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: onSubmit,
                child: Text(
                  'OK',
                  style: context.textStyle14.copyWith(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
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
