import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AboutMe.dart';
import 'Home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      debugShowCheckedModeBanner: false,
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
  // int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        // onPageChanged: (int page) {
        //   setState(() {
        //     _currentPage = page;
        //   });
        // },
        children: [
          HomePage(onNavigate: _navigateToPage),
          const AboutMePage(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      toolbarHeight: 60,
      actions: <Widget>[
        _NavButton(label: 'HOME', onPressed: () => _navigateToPage(0)),
        _NavButton(label: 'ABOUT ME', onPressed: () => _navigateToPage(1)),
        _NavButton(
          label: 'PROJECTS',
          onPressed: () {
            // TODO: Implement projects page
          },
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _NavButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.abrilFatface(
          fontSize: 16,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
