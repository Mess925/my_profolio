import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 60,
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
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/han.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment(-15, 0),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 800;
                  return SizedBox(
                    height:
                        MediaQuery.of(context).size.height -
                        120, // adjust for appbar & padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ABOUT ME',
                          style: GoogleFonts.abrilFatface(
                            fontSize: isMobile ? 32 : 48,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Hi, I\'m Han Min Thant',
                          style: GoogleFonts.abrilFatface(
                            fontSize: isMobile ? 24 : 32,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: isMobile ? double.infinity : 700,
                          child: Text(
                            'I\'m a recent graduate with a Bachelor\'s degree in Computer Science, earning first-class honors. I’m passionate about mobile development and specialize in building intuitive, high-performance apps using Flutter for cross-platform development and Swift for iOS. My goal is to create seamless user experiences and innovative mobile solutions.',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.6,
                            ),
                          ),
                        ),
                        const Spacer(), // pushes icons to bottom
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _socialButton(FontAwesomeIcons.linkedin),
                            const SizedBox(width: 12),
                            _socialButton(FontAwesomeIcons.github),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: FaIcon(icon, color: Colors.black, size: 28),
      ),
    );
  }
}
