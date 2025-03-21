import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';
import 'package:interview_junior_flutter/core/utils/snack_bar_util.dart';
import 'package:interview_junior_flutter/core/widgets/appbar_global.dart';
import 'package:interview_junior_flutter/core/widgets/btn_gradient_global.dart';
import 'package:interview_junior_flutter/core/widgets/input_field_global.dart';
import 'package:interview_junior_flutter/core/widgets/loading_screen_global.dart';
import 'package:interview_junior_flutter/core/widgets/m_scaffold.dart';
import 'package:interview_junior_flutter/features/home/domain/models/task_model.dart';
import 'package:interview_junior_flutter/features/home/presentation/bloc/home_bloc.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatefulWidget {
  final dynamic request;

  const TaskDetailScreen({super.key, this.request});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  /// TXT CONTROLLER
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<HomeBloc>().add(TaskDetailInitialEvent(widget.request));
      if (widget.request != null && widget.request is TaskModel) {
        titleController.text = widget.request.title;
        descriptionController.text = widget.request.description;
        dueDateController.text = TaskModel.convertToDisplayFormat(
          widget.request.due_date,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    context.read<HomeBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MScaffold(
        appBar: AppbarGlobal(
          title: Text(
            'Add Task',
            style: context.textStyle24.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          centerTitle: true,
          leadingWidth: 36,
          widgetLeft: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, size: 24),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (__, state) {
            if (state is TaskDetailLoadSuccess) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Column(
                          children: [
                            /// TITLE FIELD
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Title', style: context.textStyle16),
                                Text(
                                  '*',
                                  style: context.textStyle16.copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            InputFieldGlobal(
                              ctrl: titleController,
                              onChanged: (value) {
                                context.read<HomeBloc>().add(
                                  ChangedInputTaskEvent(value, 'title'),
                                );
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                }
                                return null;
                              },
                              hintText: 'Enter your title',
                              borderWidth: 0.5,
                              borderColor: Colors.grey.shade400,
                              borderRadius: 8,
                              keyboardType: TextInputType.text,
                              fillColor: Colors.white,
                            ),

                            /// DESCRIPTION FIELD
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Description', style: context.textStyle16),
                                Text(
                                  '*',
                                  style: context.textStyle16.copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),
                            InputFieldGlobal(
                              ctrl: descriptionController,
                              onChanged: (value) {
                                context.read<HomeBloc>().add(
                                  ChangedInputTaskEvent(value, 'description'),
                                );
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                }
                                return null;
                              },
                              hintText: 'Enter your description',
                              borderWidth: 0.5,
                              borderColor: Colors.grey.shade400,
                              borderRadius: 8,
                              keyboardType: TextInputType.text,
                              fillColor: Colors.white,
                            ),

                            /// DUE DATE
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Due Date', style: context.textStyle16),
                                Text(
                                  '*',
                                  style: context.textStyle16.copyWith(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),
                            InputFieldGlobal(
                              ctrl: dueDateController,
                              onChanged: (value) {
                                context.read<HomeBloc>().add(
                                  ChangedInputTaskEvent(value, 'due_date'),
                                );
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please fill in this field';
                                }
                                var regExp = RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$');
                                if (!regExp.hasMatch(val)) {
                                  return 'Invalid format (dd/MM/yyyy)';
                                }
                                List<String> parts = val.split('/');
                                if (parts.length != 3) {
                                  return 'Invalid format (dd/MM/yyyy)';
                                }
                                String day = parts[0].padLeft(2, '0');
                                String month = parts[1].padLeft(2, '0');
                                String year = parts[2];
                                String normalizedDate = '$day/$month/$year';
                                try {
                                  DateFormat(
                                    'dd/MM/yyyy',
                                  ).parseStrict(normalizedDate);
                                } catch (e) {
                                  return 'Invalid date value';
                                }
                                return null;
                              },
                              hintText: 'Enter your due date',
                              borderWidth: 0.5,
                              borderColor: Colors.grey.shade400,
                              borderRadius: 8,
                              keyboardType: TextInputType.datetime,
                              fillColor: Colors.white,
                            ),

                            /// COUNTRY FIELD
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),

                    /// ADD RECEIVER BTN
                    const SizedBox(height: 12),
                    BlocListener<HomeBloc, HomeState>(
                      listenWhen: (previous, current) {
                        if (previous is TaskDetailLoadSuccess &&
                            current is TaskDetailLoadSuccess) {
                          return previous.isLoading == true &&
                              current.isLoading == false;
                        }
                        return false;
                      },
                      listener: (__, state) {
                        if (state is TaskDetailLoadSuccess) {
                          if (state.isHandleSuccess) {
                            Navigator.of(context).pop(true);
                            SnackBarUtil.showSuccess(
                              context,
                              "${widget.request != null ? 'Update' : 'Create'} task successfully!",
                            );
                          } else {
                            SnackBarUtil.showError(
                              context,
                              "Create task failed. Try again.",
                            );
                          }
                        }
                      },
                      child: ButtonGradientGlobal(
                        isLoading: state.isLoading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            if (widget.request != null) {
                              context.read<HomeBloc>().add(
                                UpdateTaskEvent(widget.request.id),
                              );
                            } else {
                              context.read<HomeBloc>().add(
                                const CreateTaskEvent(),
                              );
                            }
                          }
                        },
                        width: MediaQuery.of(context).size.width / 2,
                        color1: AppColors.primary,
                        color2: AppColors.primary.withOpacity(.6),
                        child: Center(
                          child: Text(
                            widget.request != null ? 'Update' : 'Add',
                            style: context.textStyle16.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            } else if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: context.textStyle16,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return const LoadingScreenGlobal();
            }
          },
        ),
      ),
    );
  }
}
