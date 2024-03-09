import 'package:flutter/material.dart';
import 'package:recipe_realm/main.dart';


class Intro extends StatefulWidget {
  @override
  IntroState createState() => IntroState();
}

class IntroState extends State<Intro>
    with SingleTickerProviderStateMixin {


bool isFinish = false;


  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isFinish = true;
      });
    });



    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),


    
    );

    animation = Tween<double>(
      begin: 1,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Stack(
          children: [
            if (!isFinish)
            Center(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: animation.value,
                    child: Image.asset(
                      'assets/images/logo-t.png',
                      width: 100,
                      height: 100,
                    ),
                  );
                },
              ),
            ),
            
            if(isFinish)
            MyHomePage()
            
          ],
        ),
      ),
    );
  }
}
