import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/data/repositories/auth_repository.dart';
import 'package:weather_app/ui/Weather/widget/authentication_screen.dart';
import 'package:weather_app/ui/Weather/widget/city_weather_river.dart';
import 'package:weather_app/ui/Weather/widget/local_weather_river.dart';
import 'package:weather_app/ui/Weather/widget/profile_page.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _currentActiveScreenIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _currentActiveScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = ref.read(authRepositoryProvider);

    Widget activePage = CityWeatherRiver();

    if (_currentActiveScreenIndex == 1) {
      activePage = LocalWeatherRiver();
    } else if (_currentActiveScreenIndex == 2) {
      activePage = ProfilePage();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App 2.0",
        ),
        actions: [
          IconButton(
            onPressed: () {
              try {
                authenticationProvider.signOut();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthenticationScreen(),
                  ),
                );
              } on FirebaseAuthException catch (e) {
                Fluttertoast.showToast(
                  msg: e.code,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.SNACKBAR,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 14,
                );
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentActiveScreenIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: "City Weather",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_location_rounded),
            label: "Local Weather",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: activePage,
      ),
    );
  }
}
