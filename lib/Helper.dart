double getFontSize(
  double mobile,
  double tablet,
  double desktop,
  bool isMobile,
  bool isTablet,
) {
  if (isMobile) return mobile;
  if (isTablet) return tablet;
  return desktop;
}
