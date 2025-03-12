import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/login/loginuser.dart';
import '/login/signup.dart';

class LoginsignupWidget extends StatefulWidget {
  @override
  _LoginsignupWidgetState createState() => _LoginsignupWidgetState();
}

class _LoginsignupWidgetState extends State<LoginsignupWidget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator LoginsignupWidget - FRAME

    return Container(
      width: 393,
      height: 852,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Stack(
        children: <Widget>[
          // Background image as a Container
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Mapsbg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          Positioned(
            top: 560,
            left: 50,
            child: GestureDetector(
              onTap: () {
                // LoginBuddy screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginWidget()),
                );
              },
              child: Container(
                width: 313,
                height: 53,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 313,
                        height: 53,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Color.fromRGBO(69, 178, 143, 1),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 130,
                      child: Text(
                        'Login',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Inter',
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), Positioned(
            top: 630,
            left: 50,
            child: GestureDetector(
              onTap: () {
                // Navigate to Signup screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupWidget()),
                );
              },
              child: Container(
                width: 313,
                height: 53,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 313,
                        height: 53,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: Color.fromRGBO(69, 178, 143, 1),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 125,
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(69, 178, 143, 1),
                          fontFamily: 'Inter',
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), Positioned(
            top: 170,
            left: 0,
            child: Container(
              width: 393,
              height: 393,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/loginpicture.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: (MediaQuery.of(context).size.width - 100) / 2, // Center logo
            child: SvgPicture.asset(
              'assets/images/logoNoBg.svg',
              semanticsLabel: 'logoNoBg',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
