import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_junior_flutter/core/configs/app_router.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/themes/app_color.dart';
import 'package:interview_junior_flutter/core/utils/snack_bar_util.dart';
import 'package:interview_junior_flutter/core/widgets/input_field_global.dart';
import 'package:interview_junior_flutter/core/widgets/loading_screen_global.dart';
import 'package:interview_junior_flutter/core/widgets/m_scaffold.dart';
import 'package:interview_junior_flutter/features/dashboard/domain/models/user_info_model.dart';
import 'package:interview_junior_flutter/features/home/const/tasksStatus.dart';
import 'package:interview_junior_flutter/features/home/presentation/bloc/home_bloc.dart';
import 'package:interview_junior_flutter/features/home/presentation/widgets/confirm_delete_dialog.dart';
import 'package:interview_junior_flutter/features/home/presentation/widgets/tab_filter_task_item.dart';
import 'package:interview_junior_flutter/features/home/presentation/widgets/task_item.dart';
import 'package:interview_junior_flutter/features/home/presentation/widgets/user_profile_header.dart';

class HomeScreen extends StatefulWidget {
  final UserInfoModel userInfoModel;

  const HomeScreen({super.key, required this.userInfoModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<HomeBloc>().add(const HomeInitialEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
    context.read<HomeBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (__, state) {
            if (state is HomeLoadSuccess) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  /// HEADER
                  const SizedBox(height: 35),
                  UserProfileHeader(model: widget.userInfoModel),
                  const SizedBox(height: 24),

                  /// TABBAR
                  SizedBox(
                    height: 45,
                    child: ListView.separated(
                      itemCount: tasksStatus.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (c, i) => const SizedBox(width: 8),
                      itemBuilder: (_, index) {
                        return TabFilterTaskItem(
                          statusTitle: tasksStatus[index],
                          isSelected: state.tabSelect == tasksStatus[index],
                          onTap: () {
                            context.read<HomeBloc>().add(
                              TabChangeEvent(tasksStatus[index]),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  /// SEARCH INPUT
                  const SizedBox(height: 24),
                  InputFieldGlobal(
                    ctrl: searchTaskController,
                    onChanged: (value) {
                      context.read<HomeBloc>().add(SearchTaskEvent(value));
                    },
                    hintText: 'Enter your task title...',
                    borderWidth: 0.5,
                    borderColor: Colors.grey.shade400,
                    borderRadius: 12,
                    keyboardType: TextInputType.text,
                    fillColor: Colors.white,
                    prefixIcon: Image.asset(
                      'assets/icons/ic_search.png',
                      width: 24,
                      height: 24,
                    ),
                  ),

                  /// TASKS LIST
                  state.tasksByFilter.isEmpty
                      ? Expanded(
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.width / 4,
                              ),
                              Image.asset(
                                'assets/images/img_none_result.png',
                                width: 200,
                                height: 200,
                              ),
                              Text(
                                'List tasks is empty',
                                style: context.textStyle14.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 36),
                            Expanded(
                              child: ListView.separated(
                                itemCount: state.tasksByFilter.length,
                                padding: EdgeInsets.only(bottom: 120),
                                shrinkWrap: true,
                                separatorBuilder:
                                    (c, i) => const SizedBox(height: 16),
                                itemBuilder: (__, index) {
                                  return TaskItem(
                                    model: state.tasksByFilter[index],
                                    onTap: () async {
                                      final isRefresh = await Navigator.of(
                                        context,
                                      ).pushNamed(
                                        AppRoutes.taskDetail,
                                        arguments: state.tasksByFilter[index],
                                      );
                                      if (isRefresh != null &&
                                          isRefresh is bool) {
                                        context.read<HomeBloc>().add(
                                          HomeInitialEvent(),
                                        );
                                      }
                                    },
                                    onChangeStatus: (status) {
                                      context.read<HomeBloc>().add(
                                        ToggleStatusEvent(
                                          state.tasksByFilter[index],
                                        ),
                                      );
                                    },
                                    onDelete: () {
                                      showModalBottomSheet(
                                        backgroundColor:
                                            AppColors.contentColorWhite,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16),
                                          ),
                                        ),
                                        context: context,
                                        builder:
                                            (__) => BlocProvider.value(
                                              value: BlocProvider.of<HomeBloc>(
                                                context,
                                              ),
                                              child: BlocListener<
                                                HomeBloc,
                                                HomeState
                                              >(
                                                listenWhen: (
                                                  previous,
                                                  current,
                                                ) {
                                                  if (previous
                                                          is HomeLoadSuccess &&
                                                      current
                                                          is HomeLoadSuccess) {
                                                    return previous.isLoading ==
                                                            true &&
                                                        current.isLoading ==
                                                            false;
                                                  }
                                                  return false;
                                                },
                                                listener: (__, state) {
                                                  if (state
                                                      is HomeLoadSuccess) {
                                                    if (state.isHandleSuccess) {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                      SnackBarUtil.showSuccess(
                                                        context,
                                                        "Delete receiver successfully!",
                                                      );
                                                    } else {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                      SnackBarUtil.showError(
                                                        context,
                                                        "Delete receiver failed. Try again.",
                                                      );
                                                    }
                                                  }
                                                },
                                                child: BlocBuilder<
                                                  HomeBloc,
                                                  HomeState
                                                >(
                                                  builder: (__, state) {
                                                    if (state
                                                        is HomeLoadSuccess) {
                                                      return ConfirmDeleteDialog(
                                                        isLoading:
                                                            state.isLoading,
                                                        onDelete:
                                                            () => context
                                                                .read<
                                                                  HomeBloc
                                                                >()
                                                                .add(
                                                                  DeleteTaskEvent(
                                                                    state
                                                                            .tasksByFilter[index]
                                                                            .id ??
                                                                        -1,
                                                                  ),
                                                                ),
                                                      );
                                                    } else if (state
                                                        is HomeError) {
                                                      return Center(
                                                        child: Text(
                                                          state.message,
                                                          style:
                                                              context
                                                                  .textStyle16,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      );
                                                    } else {
                                                      return Center(
                                                        child:
                                                            const LoadingScreenGlobal(),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                ],
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
              return Center(child: const LoadingScreenGlobal());
            }
          },
        ),
      ),
    );
  }
}
