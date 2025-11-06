import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Helper.dart';
import 'WelcomePage.dart';

class ContactPage extends StatelessWidget {
  final Function(int)? onNavigate;
  static const String email = 'hanminthant222@gmail.com';

  const ContactPage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final isTablet =
            constraints.maxWidth >= 800 && constraints.maxWidth < 1200;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: isMobile
                    ? _buildMobileLayout(isMobile, isTablet)
                    : _buildDesktopLayout(isMobile, isTablet),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(bool isMobile, bool isTablet) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(30, isMobile, isTablet),
        const SizedBox(height: 20),
        _buildContactCard(25, 16, isMobile, isTablet),
        const SizedBox(height: 40),
        SocialButtonsRow(isMobile: isMobile, isTablet: isTablet),
      ],
    );
  }

  Widget _buildDesktopLayout(bool isMobile, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(
                  getFontSize(25, 30, 50, isMobile, isTablet),
                  isMobile,
                  isTablet,
                ),
                const SizedBox(height: 20),
                _buildContactCard(30, 20, isMobile, isTablet),
              ],
            ),
          ),
        ),
        const SizedBox(width: 60),
        Flexible(
          flex: 1,
          child: SocialButtonsRow(isMobile: isMobile, isTablet: isTablet),
        ),
      ],
    );
  }

  Widget _buildTitle(double fontSize, bool isMobile, bool isTablet) {
    return Text(
      'CONTACT',
      textAlign: TextAlign.start,
      style: GoogleFonts.abrilFatface(fontSize: fontSize, color: Colors.white),
    );
  }

  Widget _buildContactCard(
    double titleSize,
    double bodySize,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 20,
        vertical: 40,
      ),
      decoration: _cardDecoration(),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: _buildContactText(titleSize, bodySize),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 20,
          spreadRadius: 5,
        ),
      ],
    );
  }

  Widget _buildContactText(double titleSize, double bodySize) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: GoogleFonts.roboto(
          fontSize: bodySize,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        children: [
          TextSpan(
            text: 'Want to Develop a Mobile App?\n\n',
            style: GoogleFonts.abrilFatface(
              fontSize: titleSize,
              color: Colors.white,
            ),
          ),
          const TextSpan(
            text:
                '''I am currently prioritizing projects in social, education and new 
ideas. Send me an E-mail with your details at ''',
          ),
          TextSpan(
            text: email,
            style: GoogleFonts.roboto(
              fontSize: bodySize,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchEmail(email),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Project Inquiry',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint('Could not launch email client');
    }
  }
}
