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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          return Container(
            width: double.infinity,
            height: constraints.maxHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/han.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: SizedBox(
                    height: isMobile ? 620 : 600,
                    child: Column(
                      children: [
                        Text(
                          'CONTACT ME',
                          style: GoogleFonts.abrilFatface(
                            fontSize: isMobile ? 32 : 48,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: isMobile ? double.infinity : 700,
                          child: Text(
                            'Let\'s Work Together',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.white,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: isMobile ? double.infinity : 700,
                          child: Text(
                            'Get In touch For More Opportunities!',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.white,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialButton(FontAwesomeIcons.linkedin, isMobile),
                            const SizedBox(width: 12),
                            _socialButton(FontAwesomeIcons.github, isMobile),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialButton(FontAwesomeIcons.envelope, isMobile),
                            const SizedBox(width: 12),
                            _socialButton(FontAwesomeIcons.linktree, isMobile),
                            const SizedBox(width: 12),
                            _socialButton(FontAwesomeIcons.phone, isMobile),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _socialButton(IconData icon, bool isMobile) {
    final double buttonSize = isMobile ? 60 : 80;
    final double iconSize = isMobile ? 50 : 70;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(3),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: FaIcon(
          icon,
          color: Colors.white.withOpacity(0.9),
          size: iconSize,
        ),
      ),
    );
  }
}
