import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  const ScrollablePages({Key? key}) : super(key: key);

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
          _buildAboutPage(),
          _buildProjectsPage(),
          _buildContactPage(),
        ],
      ),
    );
  }

  Widget _buildAboutPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey.shade900, Colors.grey.shade800],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ABOUT ME',
                style: GoogleFonts.abrilFatface(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, I\'m Han!',
                        style: GoogleFonts.abrilFatface(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'I\'m a passionate mobile app developer with expertise in creating beautiful and functional applications. I specialize in Flutter development and love bringing ideas to life through code.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Skills',
                        style: GoogleFonts.abrilFatface(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildSkillChip('Flutter'),
                      _buildSkillChip('Dart'),
                      _buildSkillChip('Mobile Development'),
                      _buildSkillChip('UI/UX Design'),
                      _buildSkillChip('Firebase'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        skill,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _buildProjectsPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade900, Colors.purple.shade900],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PROJECTS',
                style: GoogleFonts.abrilFatface(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView(
                  children: [
                    _buildProjectCard(
                      'Project 1',
                      'A beautiful mobile application',
                      Icons.phone_android,
                    ),
                    _buildProjectCard(
                      'Project 2',
                      'E-commerce platform',
                      Icons.shopping_cart,
                    ),
                    _buildProjectCard(
                      'Project 3',
                      'Social media app',
                      Icons.people,
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

  Widget _buildProjectCard(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.abrilFatface(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.teal.shade900, Colors.green.shade800],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTACT',
                style: GoogleFonts.abrilFatface(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email, size: 80, color: Colors.white),
                      const SizedBox(height: 30),
                      Text(
                        'Let\'s work together!',
                        style: GoogleFonts.abrilFatface(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Get in touch for opportunities',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.linkedin,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: const FaIcon(
                                FontAwesomeIcons.github,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                      offset: const Offset(-12, -64),
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
                      offset: const Offset(-136, -114),
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
                      offset: const Offset(66, -4),
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
                  padding: const EdgeInsets.all(40),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.github,
                            color: Colors.black,
                            size: 30,
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
