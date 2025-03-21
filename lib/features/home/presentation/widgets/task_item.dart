import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';
import 'package:interview_junior_flutter/core/widgets/m_container_shadow.dart';
import 'package:interview_junior_flutter/features/home/domain/models/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel model;
  final Function() onTap;
  final Function(bool?) onChangeStatus;
  final Function() onDelete;

  const TaskItem({
    super.key,
    required this.model,
    required this.onTap,
    required this.onChangeStatus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MContainerShadow(
        backgroundColor: Colors.white,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: model.status == 1 ? true : false,
                  onChanged: onChangeStatus,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  activeColor: AppColors.primary,
                  checkColor: AppColors.contentColorWhite,
                  side: BorderSide(
                    color: AppColors.contentColorBlack,
                    width: 1.5,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: context.textStyle16.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.contentColorBlack,
                        decoration:
                            model.status == 1
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                        decorationColor: AppColors.contentColorBlack,
                      ),
                    ),
                    Text(
                      model.description,
                      style: context.textStyle14.copyWith(
                        color: AppColors.contentColorGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_calender.svg',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          TaskModel.convertToDisplayFormat(model.due_date),
                          style: context.textStyle12.copyWith(
                            color: AppColors.contentColorBlack,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: onDelete,
              color: Colors.red.withOpacity(.2),
              icon: Icon(Icons.delete, size: 24, color: Color(0xFFB71C1C)),
            ),
          ],
        ),
      ),
    );
  }
}
