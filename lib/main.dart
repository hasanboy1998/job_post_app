import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/injection/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://azydfyggfyflxfenocjn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF6eWRmeWdnZnlmbHhmZW5vY2puIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU4ODkyNTMsImV4cCI6MjA3MTQ2NTI1M30.nqMUHGK-jB_NSVF9RGhsmiGVu7FXLsTHTuCUiZo346A',
  );

  configureDependencies();

  runApp(const JobPostApp());
}

class JobPostApp extends StatelessWidget {
  const JobPostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Job Post',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
