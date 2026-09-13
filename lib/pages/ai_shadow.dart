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
      title: 'IBVAP - AI Shadow & Trails',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF0F131C),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const AIShadowTrailsView(),
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

class AIShadowTrailsView extends StatefulWidget {
  const AIShadowTrailsView({super.key});

  @override
  State<AIShadowTrailsView> createState() => _AIShadowTrailsViewState();
}

class _AIShadowTrailsViewState extends State<AIShadowTrailsView> {
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
                // Main Content Canvas
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    color: AppColors.outlineVariant,
                    child: Row(
                      children: [
                        // Video Stream Area (70%)
                        Expanded(
                          flex: 7,
                          child: Container(
                            color: AppColors.surface,
                            child: const Column(
                              children: [
                                // Video Container
                                Expanded(
                                  child: VideoContainer(),
                                ),
                                // Bottom Toolbar
                                BottomToolbar(),
                              ],
                            ),
                          ),
                        ),
                        // Analytics Sidebar (30%)
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: AppColors.surface,
                            child: const AnalyticsSidebar(),
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
                icon: const Icon(Icons.notifications_none, color: AppColors.onSurfaceVariant),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.schedule, color: AppColors.onSurfaceVariant),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  _buildNavItem(Icons.dashboard, 'Command Center', false),
                  _buildNavItem(Icons.analytics, 'Detection Engine', false),
                  _buildNavItem(Icons.query_stats, 'AI Shadow & Trails', true),
                  _buildNavItem(Icons.search, 'Scene Search', false),
                  _buildNavItem(Icons.warning, 'Alerts & Risk', false),
                  _buildNavItem(Icons.radar, 'Coverage Intel', false),
                  _buildNavItem(Icons.map, 'Terrain Models', false),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      child: Container(
        decoration: BoxDecoration(
          color: active ? AppColors.surfaceContainerHigh : Colors.transparent,
          border: active
              ? const Border(left: BorderSide(color: AppColors.primaryFixedDim, width: 2))
              : null,
          borderRadius: BorderRadius.circular(0),
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

class VideoContainer extends StatelessWidget {
  const VideoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Video Feed Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuASywO_ohQcr_IZVPpb6M6PN45qE9jLzC_GAUxsGF1lcVAVwO1uGj3vun3qDhSAzzyPzkol0hTwIZxuQfFk8n1M8dpxOqmhBk9KgELU6-6wupZWU41fQCxdW57oAoe7B8GtVmXWiqjhurPN32mjDQW8yvjj92oSn_NNAjNddecEpfS4Jekff9rJKzLYq1e2KiF2WxZ1aeB8zcapa7eYHwCz02B1XO9XzWLvrDy320JQ5Jj2aNEQPjJJ',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.black),
              ),
            ),
          ),
          // SVG Overlay Canvas (replaced with CustomPaint for trails)
          Positioned.fill(
            child: CustomPaint(
              painter: TrailPainter(),
            ),
          ),
          // Bounding Box
          Positioned(
            top: 320,
            left: 410,
            child: Container(
              width: 80,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryContainer),
              ),
              child: Stack(
                children: [
                  // Corner markers
                  Positioned(
                    top: -1,
                    left: -1,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppColors.primaryContainer, width: 2),
                          left: BorderSide(color: AppColors.primaryContainer, width: 2),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -1,
                    right: -1,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppColors.primaryContainer, width: 2),
                          right: BorderSide(color: AppColors.primaryContainer, width: 2),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    left: -1,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.primaryContainer, width: 2),
                          left: BorderSide(color: AppColors.primaryContainer, width: 2),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    right: -1,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.primaryContainer, width: 2),
                          right: BorderSide(color: AppColors.primaryContainer, width: 2),
                        ),
                      ),
                    ),
                  ),
                  // ID Tag
                  Positioned(
                    top: -20,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      color: AppColors.primaryContainer,
                      child: const Text(
                        '[TRK] P-0042',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onPrimary,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Top Left Overlay HUD
          Positioned(
            top: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHighest.withOpacity(0.8),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'CAM_08_BORDER_SECTOR_4',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onSurface,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'LAT: 31.3321 N / LON: 109.9321 W',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onSurfaceVariant,
                    fontFamily: 'JetBrains Mono',
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

class TrailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Zone A polygon
    final zonePaint = Paint()
      ..color = const Color(0x0DFFDAD6)
      ..style = PaintingStyle.fill;
    final zoneBorderPaint = Paint()
      ..color = AppColors.error
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    final zonePath = Path()
      ..moveTo(50 * size.width / 1000, 450 * size.height / 600)
      ..lineTo(300 * size.width / 1000, 350 * size.height / 600)
      ..lineTo(400 * size.width / 1000, 550 * size.height / 600)
      ..lineTo(100 * size.width / 1000, 580 * size.height / 600)
      ..close();

    canvas.drawPath(zonePath, zonePaint);
    canvas.drawPath(zonePath, zoneBorderPaint);

    // Zone label
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'ZONE A - RESTRICTED',
        style: TextStyle(
          color: AppColors.error,
          fontFamily: 'JetBrains Mono',
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(180 * size.width / 1000, 470 * size.height / 600));

    // AI Shadow Trail (glowing cyan dotted line)
    final trailPaint = Paint()
      ..color = AppColors.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final trailPath = Path()
      ..moveTo(800 * size.width / 1000, 200 * size.height / 600)
      ..quadraticBezierTo(
        750 * size.width / 1000,
        300 * size.height / 600,
        650 * size.width / 1000,
        400 * size.height / 600,
      )
      ..quadraticBezierTo(
        550 * size.width / 1000,
        450 * size.height / 600,
        450 * size.width / 1000,
        480 * size.height / 600,
      );

    canvas.drawPath(trailPath, trailPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BottomToolbar extends StatelessWidget {
  const BottomToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: const Border(top: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildToolbarButton(Icons.play_arrow),
              _buildToolbarButton(Icons.pause),
              Container(
                width: 1,
                height: 16,
                color: AppColors.outlineVariant,
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              _buildToolbarButton(Icons.skip_previous),
              _buildToolbarButton(Icons.skip_next),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: const Text(
                  '1.0x',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryFixedDim,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildActionButton(
                icon: Icons.photo_camera,
                label: 'Snap',
                primary: true,
              ),
              const SizedBox(width: 8),
              _buildActionButton(
                icon: Icons.download,
                label: 'Export',
                primary: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton(IconData icon) {
    return IconButton(
      icon: Icon(icon, color: AppColors.onSurface, size: 20),
      onPressed: () {},
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool primary,
  }) {
    if (primary) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryContainer),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryContainer, size: 16),
            const SizedBox(width: 4),
            const Text(
              'Snap',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryContainer,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          border: Border.all(color: AppColors.outlineVariant),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.onSurface, size: 16),
            const SizedBox(width: 4),
            const Text(
              'Export',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.onSurface,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      );
    }
  }
}

class AnalyticsSidebar extends StatelessWidget {
  const AnalyticsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tabs
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.outlineVariant),
            ),
          ),
          child: Row(
            children: [
              _buildTab('OBJ DETAILS', true),
              _buildTab('TIMELINE', false),
              _buildTab('SIMILAR', false),
            ],
          ),
        ),
        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Identification Block
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    border: Border.all(color: AppColors.outlineVariant),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: AppColors.outlineVariant),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBlJRQh4kZ3Qg6wFQb-_azZWbkw2Dapl3UB5q6vXE9Bj1v9K1XhNSizDXBLSdAK0aF1vwE8fxdf6oXugvnAbhX_sqXG2sAfCIkZ1zU56JIaBN-64LX34W2ryKjE-KEP4p0xJnpfZwrS68eQACpuYwTPbZySv9RT4BhQQwFcM1ShCShfy5HVIEOpiE_hIDrRnFwLAIHZiAYD7AxyV2FVKQa86UI2eNPMwwBFrhlo3-9I1Vp6Ldz5dWq4',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PRIMARY CLASSIFICATION',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: AppColors.onSurfaceVariant,
                                letterSpacing: 0.5,
                              ),
                            ),
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryContainer,
                                  letterSpacing: -0.02,
                                ),
                                children: [
                                  TextSpan(text: 'HUMAN '),
                                  TextSpan(
                                    text: '98%',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.onSurface,
                                      fontFamily: 'JetBrains Mono',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'ID: P-0042',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppColors.onSurfaceVariant,
                                fontFamily: 'JetBrains Mono',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Telemetry
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.memory,
                          color: AppColors.primaryContainer,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Kinematic Telemetry',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(1),
                      color: AppColors.outlineVariant,
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildTelemetryItem('Speed (Avg)', '1.2 m/s', AppColors.primaryFixedDim),
                          _buildTelemetryItem('Heading', '274° WNW', AppColors.primaryFixedDim),
                          _buildTelemetryItem('Dwell Time', '03m 14s', AppColors.error),
                          _buildTelemetryItem('Threat Score', 'ELEVATED', AppColors.error),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Risk Meter
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'RISK ASSESSMENT PROFILE',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Text(
                          '6.8 / 10',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.onSurface,
                            fontFamily: 'JetBrains Mono',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildRiskBar(0.8),
                        _buildRiskBar(0.8),
                        _buildRiskBar(0.8),
                        _buildRiskBar(0.8),
                        _buildRiskBar(0.8),
                        _buildRiskBar(0.6, isError: true),
                        _buildRiskBar(0.6, isError: true),
                        _buildRiskBar(0.0),
                        _buildRiskBar(0.0),
                        _buildRiskBar(0.0),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Trail Timeline
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.route,
                          color: AppColors.primaryContainer,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Trail Events',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: AppColors.outlineVariant)),
                      ),
                      child: Column(
                        children: [
                          _buildTimelineEvent(
                            time: '14:02:11 Z',
                            description: 'Initial Detection (Zone C)',
                            isActive: false,
                          ),
                          const SizedBox(height: 16),
                          _buildTimelineEvent(
                            time: '14:04:45 Z',
                            description: 'Crossed Sector Boundary',
                            isActive: false,
                          ),
                          const SizedBox(height: 16),
                          _buildTimelineEvent(
                            time: '14:05:14 Z (Current)',
                            description: 'Approaching Zone A',
                            isActive: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? AppColors.primaryContainer : Colors.transparent,
              width: 2,
            ),
          ),
          color: active ? AppColors.surfaceContainerLow : Colors.transparent,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: active ? AppColors.primaryContainer : AppColors.onSurfaceVariant,
            fontFamily: 'JetBrains Mono',
          ),
        ),
      ),
    );
  }

  Widget _buildTelemetryItem(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
              fontFamily: 'JetBrains Mono',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBar(double height, {bool isError = false}) {
    return Expanded(
      child: Container(
        height: 12,
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: isError
              ? AppColors.error.withOpacity(0.6)
              : height > 0
                  ? AppColors.surfaceTint.withOpacity(0.8)
                  : AppColors.surfaceContainerHighest,
        ),
      ),
    );
  }

  Widget _buildTimelineEvent({
    required String time,
    required String description,
    required bool isActive,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 4, right: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryContainer : AppColors.outlineVariant,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [BoxShadow(color: AppColors.primaryContainer.withOpacity(0.8), blurRadius: 8)]
                : null,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: isActive ? AppColors.primaryContainer : AppColors.onSurfaceVariant,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isActive ? AppColors.error : AppColors.onSurface,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}