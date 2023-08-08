import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rod_app/homeScreen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(alignment: Alignment.center, children: [
          Container(
            height: 95,
            width: 95,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: const Color.fromARGB(255, 255, 255, 255)),
                borderRadius: BorderRadius.circular(8)),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: ' ROD \n',
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
                TextSpan(
                    text: ' APP',
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
