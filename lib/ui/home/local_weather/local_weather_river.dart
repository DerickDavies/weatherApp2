import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/ui/home/local_weather/view_model/local_weather_notifier.dart';

class LocalWeatherRiver extends ConsumerStatefulWidget {
  const LocalWeatherRiver({super.key});

  @override
  ConsumerState<LocalWeatherRiver> createState() => LocalWeatherRiverState();
}

class LocalWeatherRiverState extends ConsumerState<LocalWeatherRiver> {
  @override
  Widget build(BuildContext context) {
    final localWeatherNotifier = ref.watch(localWeatherNotifierProvider);
    ref.listen(
      localWeatherNotifierProvider,
      (previous, next) {
        next.whenOrNull(
          data: (data) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data loaded successfully')),
            );
          },
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString())),
            );
          },
        );
      },
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              ref.read(localWeatherNotifierProvider.notifier).getLocalData();
            },
            icon: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            label: Text("Get current location weather"),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 126, 45, 140)),
          ),
          const SizedBox(
            height: 15,
          ),
          Card(
            elevation: 2,
            surfaceTintColor: const Color.fromARGB(255, 195, 0, 255),
            child: ListTile(
              title: ref.read(localWeatherNotifierProvider).whenOrNull(
                data: (data) {
                  if (data == null) {
                    return Center(child: Text("No records"));
                  }
                  return Center(child: Text(data.name));
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 450,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black26,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: localWeatherNotifier.when(
                data: (data) {
                  if (data == null) {
                    return const Text("No data found");
                  }
                  return Text(data.toString());
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return CircularProgressIndicator();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
