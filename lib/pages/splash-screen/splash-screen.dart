import 'package:flutter/material.dart';
import 'package:project_filtro/comum/backImage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controllerLoading =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);

  late final Animation<AlignmentGeometry> animationLoading =
      Tween<AlignmentGeometry>(
              begin: Alignment.centerLeft, end: Alignment.center)
          .animate(
    CurvedAnimation(parent: controllerLoading, curve: Curves.linear),
  );

  late final Animation<AlignmentGeometry> animationLoading2 =
      Tween<AlignmentGeometry>(
              begin: Alignment.bottomRight, end: Alignment.center)
          .animate(
    CurvedAnimation(parent: controllerLoading, curve: Curves.linear),
  );

  @override
  void initState() {
    controllerLoading.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          BackImage(),
          // Adicione a imagem da splash 0 primeiro
          Positioned(
            top: size.height * 0.32,
            left: size.width * 0.015,
            right: size.width * 0.015,
            child: SizedBox(
              width: size.width * 0.40,
              height: size.height * 0.35,
              child: Image.asset('assets/splash/splash_0.png'),
            ),
          ),
          // Em seguida, adicione as imagens da splash 1 e 2
          Positioned(
            top: size.height * 0.46,
            left: -290,
            right: -290,
            child: AlignTransition(
              alignment: animationLoading,
              child: SizedBox(
                width: size.width * 0.50,
                height: size.height * 0.23,
                child: Image.asset('assets/splash/splash_1.png'),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.34,
            left: -295,
            right: -290,
            child: AlignTransition(
              alignment: animationLoading2,
              child: SizedBox(
                width: size.width * 0.35,
                height: size.height * 0.20,
                child: Image.asset('assets/splash/splash_2.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
