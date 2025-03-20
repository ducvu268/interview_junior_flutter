import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_junior_flutter/features/dashboard/domain/models/user_info_model.dart';
import 'package:interview_junior_flutter/features/dashboard/domain/repositories/dashboard_repository.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;

  DashboardBloc({required this.dashboardRepository})
    : super(DashboardInitial()) {
    on<InitialDataEvent>(onDashboardInitial);
    on<EventChangeScreen>(onChangeScreen);
  }

  Future<void> onDashboardInitial(
    InitialDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final userInfoModel = UserInfoModel(
        id: '001',
        email: 'ducvuglotec@gmail.com',
        phoneNumber: '0332940384',
      );
      emit(DashboardLoadSuccess(false, 0, userInfoModel));
    } catch (e) {
      debugPrint('Error initial dashboard screen data: $e');
      emit(DashboardError(e.toString()));
    }
  }

  void onChangeScreen(
    EventChangeScreen event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoadSuccess) {
      final currentState = state as DashboardLoadSuccess;
      emit(currentState.copyWith(pageIndex: event.currentPageIndex));
    }
  }
}
