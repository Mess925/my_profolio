import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

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
          image: DecorationImage(
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'CONTACT',
                          style: GoogleFonts.abrilFatface(
                            fontSize: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisSize:
                                MainAxisSize.min, // keeps column tight
                            children: [
                              Icon(Icons.email, size: 80, color: Colors.white),
                              const SizedBox(height: 30),
                              Text(
                                'Let\'s work together!',
                                style: GoogleFonts.abrilFatface(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Get in touch for opportunities',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: isMobile
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.start,
                        children: [
                          _socialButton(FontAwesomeIcons.linkedin),
                          const SizedBox(width: 12),
                          _socialButton(FontAwesomeIcons.github),
                        ],
                      ),
                    ],
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
