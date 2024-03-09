import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Credit extends StatefulWidget {
  @override
  _CreditState createState() => _CreditState();
}

class _CreditState extends State<Credit> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 48,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(98, 0, 0, 0),
                      blurRadius: 10,
                    ),
                  ],
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "CREDITS",
                    style: TextStyle(
                      color: Color.fromARGB(186, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 2, bottom: 2),
                            child: AnimatedCard(
                              delay: 0,
                              animationController: _animationController,
                              child: OldCard(
                                imageWidth: 110,
                                texture:
                                    AssetImage("assets/images/texture-dev.png"),
                                cardColor: Color(0xFF8E97FE),
                                height: 250,
                                title: 'PRAS Samin',
                                content: 'Developer',
                                social: 'Github',
                                url: 'https://github.com/PRASSamin',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 2, bottom: 2),
                            child: AnimatedCard(
                              delay: 200,
                              animationController: _animationController,
                              child: OldCard(
                                texture:
                                    AssetImage("assets/images/texture-api2.png"),
                                cardColor: Color.fromARGB(255, 255, 163, 34),
                                height: 250,
                                title: 'TheMealDB',
                                content: 'Recipe API',
                                social: 'Website',
                                url: 'https://www.themealdb.com/',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 2, top: 2),
                            child: AnimatedCard(
                              delay: 400,
                              animationController: _animationController,
                              child: OldCard(
                                texture:
                                    AssetImage("assets/images/texture-api.png"),
                                cardColor: Color(0xFF6ACC00),
                                height: 250,
                                title: 'Edamam',
                                content: 'Recipe Search API',
                                social: 'Website',
                                url: 'https://www.edamam.com/',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 2, top: 2),
                            child: AnimatedCard(
                              delay: 600,
                              animationController: _animationController,
                              child: OldCard(
                                texture:
                                    AssetImage("assets/images/texture-flut.png"),
                                cardColor: Color(0xFF66BCEB),
                                height: 250,
                                title: 'Flutter',
                                content: 'Development Kit',
                                social: 'Website',
                                url: 'https://flutter.dev/',
                              ),
                            ),
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

class AnimatedCard extends StatelessWidget {
  final int delay;
  final AnimationController animationController;
  final Widget child;

  AnimatedCard({
    required this.delay,
    required this.animationController,
    required this.child,
  }) : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          (delay / 1000),
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform.translate(
            offset: Offset(0.0, 100 * (1 - animation.value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class OldCard extends StatelessWidget {
  final String title;
  final String content;
  final String social;
  final double height;
  final Color cardColor;
  final ImageProvider texture;
  final double imageWidth;
  final String url;

  const OldCard({
    required this.title,
    required this.content,
    this.social = "",
    this.height = 100.0,
    required this.cardColor,
    required this.texture,
    this.imageWidth = 100,
    this.url = '',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: SizedBox(
        height: height,
        child: Card(
          color: cardColor,
          elevation: 3,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: imageWidth,
                        child: Image(
                          image: texture,
                          width: imageWidth,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 29),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 103),
                            Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              content,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.link),
                                SizedBox(width: 2),
                                Text(
                                  social,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
