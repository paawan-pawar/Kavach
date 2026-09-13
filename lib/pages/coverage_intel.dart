import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import '../routes/side_navigation_bar.dart' as navigation;
import '../widgets/kavach_logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IBVAP - Coverage Intel',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF0F131C),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const CoverageIntelView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Color palette from the HTML
class AppColors {
  static const Color background = Color(0xFF0F131C);
  static const Color surface = Color(0xFF0F131C);
  static const Color surfaceContainer = Color(0xFF1C1F29);
  static const Color surfaceContainerLow = Color(0xFF181B25);
  static const Color surfaceContainerLowest = Color(0xFF0A0E17);
  static const Color surfaceContainerHigh = Color(0xFF262A34);
  static const Color surfaceContainerHighest = Color(0xFF31353F);
  static const Color surfaceVariant = Color(0xFF31353F);
  static const Color onSurface = Color(0xFFDFE2EF);
  static const Color onSurfaceVariant = Color(0xFFBAC9CC);
  static const Color primary = Color(0xFF00DAF3);
  static const Color primaryContainer = Color(0xFF00E5FF);
  static const Color primaryFixedDim = Color(0xFF00DAF3);
  static const Color onPrimary = Color(0xFF00363D);
  static const Color error = Color(0xFFFFB4AB);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color outline = Color(0xFF849396);
  static const Color outlineVariant = Color(0xFF3B494C);
  static const Color surfaceTint = Color(0xFF00DAF3);
}

class CoverageIntelView extends StatefulWidget {
  const CoverageIntelView({super.key});

  @override
  State<CoverageIntelView> createState() => _CoverageIntelViewState();
}

class _CoverageIntelViewState extends State<CoverageIntelView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Navigation Bar
          const TopNavBar(),
          // Main Content
          Expanded(
            child: Row(
              children: [
                // Side Navigation Bar
                const navigation.AppSideNavigationBar(),
                // Main Viewport
                Expanded(
                  child: Row(
                    children: [
                      // Interactive Tactical Map Area
                      Expanded(
                        child: Container(
                          color: AppColors.surfaceContainerLowest,
                          child: const TacticalMap(),
                        ),
                      ),
                      // Right Panel: Actionable Intel
                      const ActionableIntelPanel(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopNavBar extends StatelessWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: AppColors.primaryContainer),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.schedule, color: AppColors.primaryContainer),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: double.infinity,
      color: AppColors.surfaceContainerLowest,
      child: Column(
        children: [
          // Brand Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.onSurface),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 12),
                const KavachLogo(size: 40, padding: EdgeInsets.zero),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'IBVAP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                        height: 1.2,
                      ),
                    ),
                    const Text(
                      'Border Security',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.onSurfaceVariant,
                        letterSpacing: 0.5,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.outlineVariant, height: 1),
          // Navigation Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  _buildNavItem(Icons.dashboard, 'Command Center', false),
                  _buildNavItem(Icons.analytics, 'Detection Engine', false),
                  _buildNavItem(Icons.query_stats, 'AI Shadow & Trails', false),
                  _buildNavItem(Icons.search, 'Scene Search', false),
                  _buildNavItem(Icons.warning, 'Alerts & Risk', false),
                  _buildNavItem(Icons.radar, 'Coverage Intel', true),
                  _buildNavItem(Icons.map, 'Terrain Models', false),
                  const Spacer(),
                  _buildNavItem(Icons.settings, 'Admin', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Container(
        decoration: BoxDecoration(
          color: active ? AppColors.surfaceContainerHigh : Colors.transparent,
          borderRadius: active ? const BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ) : null,
          border: active
              ? const Border(left: BorderSide(color: AppColors.primaryFixedDim, width: 2))
              : null,
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: active ? AppColors.primaryFixedDim : AppColors.onSurfaceVariant,
            size: 20,
          ),
          title: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: active ? AppColors.onSurface : AppColors.onSurfaceVariant,
            ),
          ),
          dense: true,
          visualDensity: const VisualDensity(vertical: -2),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          onTap: () {},
        ),
      ),
    );
  }
}

class TacticalMap extends StatefulWidget {
  const TacticalMap({super.key});

  @override
  State<TacticalMap> createState() => _TacticalMapState();
}

class _TacticalMapState extends State<TacticalMap> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Background
        Positioned.fill(
          child: Opacity(
            opacity: 0.5,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuB3zWdubUv3A5LACz6oHjm6dfkaBKrOQjaZC0--Ef9X0J_lsZZgyqnnT4Jl1gLG4O66jGfBpWeX4mEUnn5UtzG3W3aQJXb37jP2eYx2o4vbitPMQ4oyhqDVhmPDOQg4BElYUmaYnGe5BJrS5nEMkAdGCcbVcVXM8IMdHd2Dffdh7-Af2M1Q4AjZdSDVs6kterTexE1qgfrlDw0hF22fVtKWDsuOjqCZfMIGX2KpxLguI6ubQdbmr3CH',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceContainerLowest),
            ),
          ),
        ),
        // Map Grid Overlay
        Positioned.fill(
          child: CustomPaint(
            painter: GridPainter(),
          ),
        ),
        // UI Overlay Controls & Legend
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Left HUD
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer.withOpacity(0.9),
                    border: Border.all(color: AppColors.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Sector 7 Alpha',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'LIVE TELEMETRY ACTIVE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryFixedDim,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.only(top: 12),
                        decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: AppColors.outlineVariant)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryContainer.withOpacity(0.2),
                                    border: const Border(left: BorderSide(color: AppColors.primaryContainer, width: 2)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Coverage Cone',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withOpacity(0.2),
                                    border: const Border(left: BorderSide(color: AppColors.error, width: 2)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Alert Zone',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Right Controls
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16, right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer.withOpacity(0.9),
                    border: Border.all(color: AppColors.outlineVariant),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      _buildMapControlButton(Icons.add),
                      _buildMapControlButton(Icons.remove),
                      _buildMapControlButton(Icons.my_location, isActive: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Map Entities Layer
        Positioned(
          top: MediaQuery.of(context).size.height * 0.28,
          left: MediaQuery.of(context).size.width * 0.48,
          child: const CoverageLoophole(),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.38,
          left: MediaQuery.of(context).size.width * 0.22,
          child: const CameraMarker(
            label: 'CAM-NW-01',
            angle: 110,
            coneWidth: 60,
            coneHeight: 140,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.58,
          left: MediaQuery.of(context).size.width * 0.38,
          child: const CameraMarker(
            label: 'CAM-SE-04',
            angle: -45,
            coneWidth: 50,
            coneHeight: 120,
          ),
        ),
      ],
    );
  }

  Widget _buildMapControlButton(IconData icon, {bool isActive = false}) {
    return Container(
      decoration: BoxDecoration(
        border: icon == Icons.my_location ? null : const Border(
          bottom: BorderSide(color: AppColors.outlineVariant),
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: isActive ? AppColors.primaryContainer : AppColors.onSurfaceVariant,
        ),
        onPressed: () {},
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3B494C).withOpacity(0.1)
      ..strokeWidth = 1;

    // Vertical lines
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CoverageLoophole extends StatelessWidget {
  const CoverageLoophole({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 192,
          height: 128,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.error, width: 2),
            color: AppColors.error.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning,
                color: AppColors.error,
                size: 32,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'BREACH RISK',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'LAT 28.61°N / LNG 77.23°E',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.error,
            fontFamily: 'JetBrains Mono',
          ),
        ),
      ],
    );
  }
}

class CameraMarker extends StatelessWidget {
  final String label;
  final double angle;
  final double coneWidth;
  final double coneHeight;

  const CameraMarker({
    super.key,
    required this.label,
    required this.angle,
    required this.coneWidth,
    required this.coneHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cone
        Transform.rotate(
          angle: angle * 3.14159 / 180,
          child: Container(
            width: 0,
            height: 0,
            child: CustomPaint(
              painter: ConePainter(coneWidth: coneWidth, coneHeight: coneHeight),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Camera Icon
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            border: Border.all(color: AppColors.primaryContainer),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryContainer.withOpacity(0.3),
                blurRadius: 12,
              ),
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: const Icon(
            Icons.videocam,
            color: AppColors.primaryContainer,
            size: 16,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            border: Border.all(color: AppColors.outlineVariant),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryFixedDim,
              fontFamily: 'JetBrains Mono',
            ),
          ),
        ),
      ],
    );
  }
}

class ConePainter extends CustomPainter {
  final double coneWidth;
  final double coneHeight;

  const ConePainter({required this.coneWidth, required this.coneHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryContainer.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(-coneWidth, coneHeight)
      ..lineTo(coneWidth, coneHeight)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ActionableIntelPanel extends StatelessWidget {
  const ActionableIntelPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      color: AppColors.surface,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.outlineVariant),
              ),
              color: AppColors.surfaceContainerLow,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.fact_check,
                      color: AppColors.primaryContainer,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Actionable Intel',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                        letterSpacing: -0.02,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '1 CRITICAL',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // High Priority Intel Card
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      border: Border.all(color: AppColors.outlineVariant),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        // Left glowing edge
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 4,
                            color: AppColors.error,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.gpp_bad,
                                        color: AppColors.error,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Loophole #1',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceContainer,
                                      border: Border.all(color: AppColors.outlineVariant),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'T-0:02:14',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.onSurfaceVariant,
                                        fontFamily: 'JetBrains Mono',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'North-East corner uncovered due to mechanical failure on CAM-NE-02. A 45-meter blind spot is currently vulnerable.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.onSurfaceVariant,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(color: AppColors.outlineVariant),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'SYSTEM RECOMMENDATION',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.outline,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Deploy personnel at coordinates\n28.61°N, 77.23°E.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryContainer,
                                        fontFamily: 'JetBrains Mono',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryContainer,
                                    foregroundColor: const Color(0xFF0A0E17),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Mark as Deployed',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Lower Priority Intel Card
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      border: Border.all(color: AppColors.outlineVariant),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        // Left edge for warning
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 4,
                            color: const Color(0xFFF59E0B),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.warning,
                                        color: Color(0xFFF59E0B),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Sensor Degradation',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceContainer,
                                      border: Border.all(color: AppColors.outlineVariant),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      '-2h',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.onSurfaceVariant,
                                        fontFamily: 'JetBrains Mono',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Thermal sensor efficiency degraded by 18% due to sandstorm residue in Sector 4.',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.onSurfaceVariant,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.primaryContainer,
                                    side: const BorderSide(color: AppColors.primaryContainer),
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.build,
                                        size: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Dispatch Maintenance',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // System Log
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.outlineVariant)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'RECENT ACTIVITY',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.onSurfaceVariant,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const Icon(
                              Icons.history,
                              size: 16,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: [
                            const LogEntry(
                              time: '[14:32:01]',
                              message: 'Drone sweep complete (Sec-2).',
                            ),
                            const LogEntry(
                              time: '[14:28:44]',
                              message: 'Patrol Alpha reached Waypoint Charlie.',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogEntry extends StatelessWidget {
  final String time;
  final String message;

  const LogEntry({
    super.key,
    required this.time,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryFixedDim,
              fontFamily: 'JetBrains Mono',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.onSurfaceVariant,
                fontFamily: 'JetBrains Mono',
              ),
            ),
          ),
        ],
      ),
    );
  }
}