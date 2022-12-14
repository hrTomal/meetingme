import 'package:flutter/material.dart';
import 'package:meetingme/models/country.dart';
import 'package:meetingme/screens/login/login_screen.dart';

import '../../services/login_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final orgCodeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Image.asset('assets/images/meetingme_logo.jpg'),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: orgCodeTextController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Organization Code',
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {
                _navigateToLoginScreen(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Let\'s Explore',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Country>> loadCountries() async {
    var data = await LoginService().getCountries();
    var countries = data.results;
    return countries;
  }

  void _navigateToLoginScreen(BuildContext context) {
    //var countries = loadCountries();
    Navigator.pushNamed(context, LoginScreen.routeName);
  }
}
