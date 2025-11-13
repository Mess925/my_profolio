import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'WelcomePage.dart';
import 'Metorshower.dart';

class HomePage extends StatefulWidget {
  final Function(int)? onNavigate;
  const HomePage({super.key, this.onNavigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _hasNavigated = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (_hasNavigated) return false;

    if (notification is OverscrollNotification) {
      if (notification.overscroll > 20) {
        _hasNavigated = true;
        if (widget.onNavigate != null) {
          widget.onNavigate!(1);
        }
        return true;
      }
    }

    if (notification is ScrollUpdateNotification) {
      if (_scrollController.hasClients) {
        final isAtBottom =
            _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent;

        if (isAtBottom &&
            notification.scrollDelta != null &&
            notification.scrollDelta! < 0) {
          _hasNavigated = true;
          if (widget.onNavigate != null) {
            widget.onNavigate!(1);
          }
          return true;
        }
      }
    }

    return false;
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (_hasNavigated) return;

    if (event is PointerScrollEvent) {
      if (_scrollController.hasClients) {
        final isAtBottom =
            _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent;

        if (isAtBottom && event.scrollDelta.dy > 0) {
          _hasNavigated = true;
          if (widget.onNavigate != null) {
            widget.onNavigate!(1);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _handlePointerSignal,
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final isTablet =
            constraints.maxWidth >= 800 && constraints.maxWidth < 1200;

        if (isMobile) {
          // Mobile layout with overscroll detection
          return MeteorShower(
            numberOfMeteors: 20,
            duration: const Duration(seconds: 10),
            meteorColor: Colors.red.withOpacity(0.6),
            child: Container(
              width: double.infinity,
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, Colors.black],
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _handleScrollNotification,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        child: HeroSection(
                          isMobile: isMobile,
                          isTablet: isTablet,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: MeteorShower(
                  numberOfMeteors: 20,
                  duration: const Duration(seconds: 10),
                  meteorColor: Colors.red.withOpacity(0.6),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.black, Colors.black],
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: HeroSection(isMobile: isMobile, isTablet: isTablet),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
