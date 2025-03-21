import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/core/configs/app_router.dart';
import 'package:interview_junior_flutter/core/widgets/m_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MScaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/img_logo_company.jfif',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 20),
            const Spacer(flex: 10),
            Center(
              child: Transform.scale(
                scale: 1.2,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  color: Theme.of(context).colorScheme.surface,
                  strokeWidth: 5,
                ),
              ),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
