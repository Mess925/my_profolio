import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'AboutMe.dart';
import 'Contact.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ScrollablePages(),
    );
  }
}

class ScrollablePages extends StatefulWidget {
  const ScrollablePages({super.key});

  @override
  State<ScrollablePages> createState() => _ScrollablePagesState();
}

class _ScrollablePagesState extends State<ScrollablePages> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        onPageChanged: (int page) {},
        children: [
          const HomePage(),
          const AboutMePage(),
          // const ProjectsPage(),
          const ContactPage(),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                child: Column(
                  children: [
                    Container(
                      height: isMobile ? 620 : 600,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Center(
                            child: Transform.translate(
                              offset: const Offset(-12, -64),
                              child: Text(
                                'HAN',
                                style: GoogleFonts.abrilFatface(
                                  fontSize: isMobile ? 128 : 128,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Transform.translate(
                              offset: const Offset(-136, -114),
                              child: Text(
                                'I am',
                                style: GoogleFonts.abrilFatface(
                                  fontSize: isMobile ? 12 : 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Transform.translate(
                              offset: const Offset(66, -4),
                              child: Text(
                                'Mobile App Developer',
                                style: GoogleFonts.abrilFatface(
                                  fontSize: isMobile ? 12 : 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: isMobile
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.start,
                        children: [
                          _socialButton(FontAwesomeIcons.linkedin),
                          const SizedBox(width: 12),
                          _socialButton(FontAwesomeIcons.github),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
