import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/data/repositories/auth/auth_repository.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Text("Profile"),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/24/84/70/248470199d7901dd9f5adbed7a6a3932.jpg",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ref.read(authRepositoryProvider).currentAuth()!.email,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "Genius, Billionaire, Playboy",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "I'm Tony Stark - billionaire with a brain, a heartbreaker with a suit, and the reason the world still spins. You're welcome.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        "FOLLOW",
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 253, 129, 57),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text("MESSAGE"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 253, 129, 57),
                      side: BorderSide(
                        color: Color.fromARGB(255, 253, 129, 57),
                        width: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "674",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 125, 125, 125),
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "PHOTOS",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 146, 146, 146),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: const Color.fromARGB(255, 255, 142, 108),
                      indent: 8,
                      endIndent: 8,
                    ),
                    Column(
                      children: [
                        Text(
                          "15K",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 125, 125, 125),
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "FOLLOWERS",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 146, 146, 146),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: const Color.fromARGB(255, 255, 142, 108),
                      indent: 8,
                      endIndent: 8,
                    ),
                    Column(
                      children: [
                        Text(
                          "23K",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 125, 125, 125),
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "FOLLOWING",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 146, 146, 146),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
