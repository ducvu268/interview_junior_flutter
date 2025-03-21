import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';
import 'package:interview_junior_flutter/core/widgets/m_container_shadow.dart';
import 'package:interview_junior_flutter/features/home/domain/models/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel model;
  final Function(bool?) onChangeStatus;
  final Function() onDelete;

  const TaskItem({
    super.key,
    required this.model,
    required this.onChangeStatus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return MContainerShadow(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: model.status == 0 ? false : true,
                onChanged: onChangeStatus,
                activeColor: AppColors.primary,
                checkColor: Colors.white,
              ),
              Column(
                children: [
                  Text(
                    model.title,
                    style: context.textStyle16.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    model.description,
                    style: context.textStyle16.copyWith(
                      color: AppColors.contentColorGrey,
                    ),
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
    );
  }
}
