import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/ui/Weather/view_model/get_weather_notifier.dart';

class HomePageRiver extends ConsumerStatefulWidget {
  HomePageRiver({super.key});

  @override
  ConsumerState<HomePageRiver> createState() => _HomePageRiverState();
}

class _HomePageRiverState extends ConsumerState<HomePageRiver> {
  final _formKey = GlobalKey<FormState>();

  final cityCodeController = TextEditingController();
  final stateCodeController = TextEditingController();
  final countryCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final weatherNotiferProvider = ref.watch(getWeatherNotifierProvider);

    // For snackbar or toast
    ref.listen(
      getWeatherNotifierProvider,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: cityCodeController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text("City Code"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter city name';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: stateCodeController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("State Code"),
                            ),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter state name';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: countryCodeController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text("Country Code"),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(getWeatherNotifierProvider.notifier).getData(
                          cityName: cityCodeController.text,
                          stateCode: stateCodeController.text,
                          countryCode: countryCodeController.text,
                        );
                  }
                },
                icon: const Icon(Icons.sunny),
                label: const Text("Get weather data"),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 130, 81, 139)),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  final repo = ref.read(weatherRepositoryProvider);
                  repo.getCurrentLocation();
                },
                child: Text("Get Current Location"),
              ),
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                ),
                alignment: Alignment.center,
                child: weatherNotiferProvider.when(
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
                    return const CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
