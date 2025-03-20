import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/widgets/m_scaffold.dart';
import 'package:interview_junior_flutter/features/dashboard/domain/models/user_info_model.dart';
import 'package:interview_junior_flutter/features/home/presentation/widgets/user_profile_header.dart';

class HomeScreen extends StatelessWidget {
  final UserInfoModel userInfoModel;

  const HomeScreen({super.key, required this.userInfoModel});

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.transparent),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 35),
          UserProfileHeader(model: userInfoModel),
          const SizedBox(height: 24),
          // PaymentMethodWidget(),
        ],
      ),
    );
  }
}
