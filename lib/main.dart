import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actionsPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text(
              'HOME',
              style: GoogleFonts.abrilFatface(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'ABOUT ME',
              style: GoogleFonts.abrilFatface(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'PROJECTS',
              style: GoogleFonts.abrilFatface(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'CONTACT',
              style: GoogleFonts.abrilFatface(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/han.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Transform.translate(
                      offset: Offset(-12, -64),
                      child: Text(
                        'HAN',
                        style: GoogleFonts.abrilFatface(
                          fontSize: 128,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Transform.translate(
                      offset: Offset(-136, -114),
                      child: Text(
                        'I am',
                        style: GoogleFonts.abrilFatface(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Transform.translate(
                      offset: Offset(66, -4),
                      child: Text(
                        'Mobile App Developer',
                        style: GoogleFonts.abrilFatface(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(40),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.github,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MyApp()));
}
