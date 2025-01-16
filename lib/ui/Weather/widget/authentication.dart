import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/ui/Weather/view_model/auth_notifier.dart';
import 'package:weather_app/ui/Weather/widget/authentication_screen.dart';
import 'package:weather_app/ui/Weather/widget/splash_screen.dart';
import 'package:weather_app/ui/Weather/widget/tabs_screen.dart';

class Authentication extends ConsumerWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(
      Duration.zero,
      () {
        ref.read(authNotifierProvider.notifier).checkAuth();
      },
    );

    ref.listen(
      authNotifierProvider,
      (previous, next) {
        next.when(data: (data) {
          if (data == null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AuthenticationScreen(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TabsScreen(),
              ),
            );
          }
        }, error: (error, stackTrace) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SplashScreen(
                isLoading: false,
              ),
            ),
          );
        }, loading: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SplashScreen(isLoading: true),
            ),
          );
        });
      },
    );

    return SplashScreen(isLoading: true);
  }
}
