import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/ui/auth/view_models/auth_notifier.dart';
import 'package:weather_app/ui/auth/authentication_screen.dart';
import 'package:weather_app/ui/home/tabs_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authNotifierProvider,
      (previous, next) {
        next.when(
          data: (data) {
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
          },
          error: (error, stackTrace) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SplashScreen(
            //       isLoading: false,
            //     ),
            //   ),
            // );

            // Snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
              ),
            );
          },
          loading: () {
            // Do nothing
            // Wait here till data
          },
        );
      },
    );
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
