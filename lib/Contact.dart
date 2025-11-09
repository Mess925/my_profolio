import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Helper.dart';
import 'WelcomePage.dart';

class ContactPage extends StatefulWidget {
  static const String email = 'hanminthant222@gmail.com';

  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isEmailCopied = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
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
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 800;
          final isTablet =
              constraints.maxWidth >= 800 && constraints.maxWidth < 1200;

          // Responsive padding
          final horizontalPadding = isMobile ? 16.0 : (isTablet ? 40.0 : 80.0);
          final verticalPadding = isMobile ? 20.0 : 40.0;

          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: ScrollConfiguration(
              behavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {...PointerDeviceKind.values},
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: isMobile
                    ? _buildMobileLayout(
                        constraints,
                        isMobile,
                        isTablet,
                        verticalPadding,
                      )
                    : _buildDesktopLayout(
                        constraints,
                        isMobile,
                        isTablet,
                        verticalPadding,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(
    BoxConstraints constraints,
    bool isMobile,
    bool isTablet,
    double verticalPadding,
  ) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 20.0 : 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              _buildTitle(28, isMobile, isTablet),
              const SizedBox(height: 40),
              _buildContactCard(20, 14, isMobile, isTablet),
              const SizedBox(height: 40),
              SocialButtonsRow(isMobile: isMobile, isTablet: isTablet),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BoxConstraints constraints,
    bool isMobile,
    bool isTablet,
    double verticalPadding,
  ) {
    double horizontalPadding = isTablet ? 20.0 : 40.0;
    // double contentWidth = constraints.maxWidth - (horizontalPadding * 2);
    double columnSpacing = isTablet ? 20.0 : 30.0;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 1200, // keeps layout neat on ultra-wide monitors
            minHeight: constraints.maxHeight - (verticalPadding * 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: isTablet ? 2 : 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(
                      getFontSize(25, 30, 50, isMobile, isTablet),
                      isMobile,
                      isTablet,
                    ),
                    const SizedBox(height: 20),
                    _buildContactCard(
                      isTablet ? 22 : 28,
                      isTablet ? 16 : 18,
                      isMobile,
                      isTablet,
                    ),
                  ],
                ),
              ),
              SizedBox(width: columnSpacing),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SocialButtonsRow(
                    isMobile: isMobile,
                    isTablet: isTablet,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(double fontSize, bool isMobile, bool isTablet) {
    return Text(
      'CONTACT',
      textAlign: isMobile ? TextAlign.center : TextAlign.start,
      style: GoogleFonts.abrilFatface(
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildContactCard(
    double titleSize,
    double bodySize,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? 400 : 600),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 24 : 32,
      ),
      decoration: _cardDecoration(),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildContactText(titleSize, bodySize),
              const SizedBox(height: 20),
              _buildEmailActions(bodySize),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.white.withOpacity(0.05),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 24,
          spreadRadius: 2,
          offset: const Offset(0, 8),
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
          color: Colors.white.withOpacity(0.9),
          letterSpacing: 0.5,
          height: 1.6,
        ),
        children: [
          TextSpan(
            text: 'Want to Develop a Mobile App?\n\n',
            style: GoogleFonts.abrilFatface(
              fontSize: titleSize,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const TextSpan(
            text:
                'I am currently prioritizing projects in social, education, and new ideas. ',
          ),
          const TextSpan(text: 'Send me an email with your details at:\n\n'),
          TextSpan(
            text: ContactPage.email,
            style: GoogleFonts.roboto(
              fontSize: bodySize,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blueAccent.withOpacity(0.6),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchEmail(ContactPage.email),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailActions(double bodySize) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildActionButton(
          icon: Icons.email_outlined,
          label: 'Send Email',
          onPressed: () => _launchEmail(ContactPage.email),
        ),
        _buildActionButton(
          icon: _isEmailCopied ? Icons.check : Icons.copy_outlined,
          label: _isEmailCopied ? 'Copied!' : 'Copy Email',
          onPressed: _copyEmailToClipboard,
          backgroundColor: _isEmailCopied ? Colors.green : null,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? backgroundColor,
  }) {
    return Material(
      color: backgroundColor ?? Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject=Project Inquiry&body=Hi, I would like to discuss a project with you.',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (mounted) {
          _showSnackBar(
            'Could not launch email client. Please copy the email address.',
          );
        }
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error opening email client. Email copied to clipboard.');
        _copyEmailToClipboard();
      }
    }
  }

  Future<void> _copyEmailToClipboard() async {
    await Clipboard.setData(const ClipboardData(text: ContactPage.email));
    setState(() {
      _isEmailCopied = true;
    });

    _showSnackBar('Email copied to clipboard!');

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isEmailCopied = false;
        });
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
