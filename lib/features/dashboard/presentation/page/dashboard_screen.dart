import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_junior_flutter/core/configs/app_router.dart';
import 'package:interview_junior_flutter/core/extensions/text_style_ext.dart';
import 'package:interview_junior_flutter/core/widgets/loading_screen_global.dart';
import 'package:interview_junior_flutter/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:interview_junior_flutter/features/dashboard/presentation/widget/bottom_nav_bar.dart';
import 'package:interview_junior_flutter/features/dashboard/presentation/widget/floating_action_btn.dart';
import 'package:interview_junior_flutter/features/home/presentation/bloc/home_bloc.dart';
import 'package:interview_junior_flutter/features/home/presentation/pages/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int? pageIndex;

  const DashboardScreen({super.key, this.pageIndex});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<DashboardBloc>().add(const InitialDataEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
    context.read<DashboardBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardBloc = context.read<DashboardBloc>();
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (__, state) {
            if (state is DashboardLoadSuccess) {
              return IndexedStack(
                index: state.pageIndex,
                children: [
                  HomeScreen(userInfoModel: state.userInfoModel),
                  HomeScreen(userInfoModel: state.userInfoModel),
                ],
              );
            } else if (state is DashboardError) {
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
        floatingActionButton: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (__, state) {
            if (state is DashboardLoadSuccess) {
              return FloatingActionButton(
                onPressed: () async {
                  final isRefresh = await Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.taskDetail);
                  if (isRefresh != null && isRefresh is bool) {
                    context.read<HomeBloc>().add(HomeInitialEvent());
                  }
                },
                backgroundColor: Colors.transparent,
                child: const FloatingActionBtn(),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (__, state) {
            if (state is DashboardLoadSuccess) {
              return BottomNavBar(
                activeIndex: state.pageIndex,
                onTap: (i) {
                  dashboardBloc.add(EventChangeScreen(i));
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
