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
      title: 'IBVAP - Alerts & Risk',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF0F131C),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const AlertsRiskView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Color palette from the HTML
class AppColors {
  static const Color surface = Color(0xFF0F131C);
  static const Color surfaceContainer = Color(0xFF1C1F29);
  static const Color surfaceContainerLow = Color(0xFF181B25);
  static const Color surfaceContainerLowest = Color(0xFF0A0E17);
  static const Color surfaceContainerHigh = Color(0xFF262A34);
  static const Color surfaceContainerHighest = Color(0xFF31353F);
  static const Color surfaceVariant = Color(0xFF31353F);
  static const Color onSurface = Color(0xFFDFE2EF);
  static const Color onSurfaceVariant = Color(0xFFBAC9CC);
  static const Color primary = Color(0xFFC3F5FF);
  static const Color primaryContainer = Color(0xFF00E5FF);
  static const Color primaryFixedDim = Color(0xFF00DAF3);
  static const Color onPrimary = Color(0xFF00363D);
  static const Color onPrimaryContainer = Color(0xFF00626E);
  static const Color error = Color(0xFFFFB4AB);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onError = Color(0xFF690005);
  static const Color outline = Color(0xFF849396);
  static const Color outlineVariant = Color(0xFF3B494C);
  static const Color tertiary = Color(0xFFE4EDFF);
  static const Color surfaceTint = Color(0xFF00DAF3);
}

class AlertsRiskView extends StatefulWidget {
  const AlertsRiskView({super.key});

  @override
  State<AlertsRiskView> createState() => _AlertsRiskViewState();
}

class _AlertsRiskViewState extends State<AlertsRiskView> {
  String _selectedSeverity = 'CRIT';
  String _selectedSector = 'ALL';
  String _selectedStatus = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation Bar
          const navigation.AppSideNavigationBar(),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top Navigation Bar
                const TopNavBar(),
                // Main Content Area
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Filter Bar
                        _buildFilterBar(),
                        const SizedBox(height: 24),
                        // Metric Summary Cards
                        _buildMetricCards(),
                        const SizedBox(height: 24),
                        // Main Interactive Alerts Table
                        _buildAlertsTable(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Right Sidebar: Sector Risk Matrix & Live Feed
          const RightSidebar(),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Severity Filter
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'SEV:',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.outline,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ),
                    _buildFilterChip('CRIT', _selectedSeverity == 'CRIT', isCritical: true),
                    _buildFilterChip('HIGH', _selectedSeverity == 'HIGH'),
                    _buildFilterChip('MED', _selectedSeverity == 'MED'),
                    _buildFilterChip('LOW', _selectedSeverity == 'LOW'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Sector Filter
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'SECTOR:',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.outline,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ),
                    _buildFilterChip('ALL', _selectedSector == 'ALL', isPrimary: true),
                    _buildFilterChip('ALPHA', _selectedSector == 'ALPHA'),
                    _buildFilterChip('BETA', _selectedSector == 'BETA'),
                    _buildFilterChip('GAMMA', _selectedSector == 'GAMMA'),
                    _buildFilterChip('DELTA', _selectedSector == 'DELTA'),
                  ],
                ),
              ),
            ],
          ),
          // Status Filter
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _buildFilterChip('Active', _selectedStatus == 'Active', isActive: true),
                    _buildFilterChip('Ack', _selectedStatus == 'Ack'),
                    _buildFilterChip('Resolved', _selectedStatus == 'Resolved'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Live Feed Toggle
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'AUTO-SYNC',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryContainer,
                        fontFamily: 'JetBrains Mono',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected,
      {bool isCritical = false, bool isPrimary = false, bool isActive = false}) {
    Color bgColor;
    Color textColor;

    if (isCritical && isSelected) {
      bgColor = AppColors.error.withOpacity(0.2);
      textColor = AppColors.error;
    } else if (isPrimary && isSelected) {
      bgColor = AppColors.primaryContainer;
      textColor = AppColors.onPrimaryContainer;
    } else if (isActive && isSelected) {
      bgColor = AppColors.surfaceContainerHigh;
      textColor = AppColors.primaryContainer;
    } else if (isSelected) {
      bgColor = AppColors.surfaceContainerHigh;
      textColor = AppColors.onSurface;
    } else {
      bgColor = Colors.transparent;
      textColor = AppColors.onSurfaceVariant;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          if (['CRIT', 'HIGH', 'MED', 'LOW'].contains(label)) {
            _selectedSeverity = label;
          } else if (['ALL', 'ALPHA', 'BETA', 'GAMMA', 'DELTA'].contains(label)) {
            _selectedSector = label;
          } else {
            _selectedStatus = label;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            color: textColor,
            fontFamily: 'JetBrains Mono',
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.8,
      children: [
        _buildMetricCard(
          title: 'TOTAL ACTIVE',
          value: '142',
          subtitle: '+12% / hr',
          icon: Icons.show_chart,
          iconColor: AppColors.primaryContainer,
          progress: 0.78,
          progressColor: AppColors.primaryContainer,
          bgIcon: Icons.warning,
        ),
        _buildMetricCard(
          title: 'CRITICAL BREACHES',
          value: '09',
          subtitle: 'SECTOR ALPHA',
          icon: Icons.home_work,
          iconColor: AppColors.error,
          progress: 0.45,
          progressColor: AppColors.error,
          bgIcon: Icons.error,
          valueColor: AppColors.error,
          subtitleColor: AppColors.error,
        ),
        _buildMetricCard(
          title: 'MEAN TIME TO ACK',
          value: '1.4s',
          subtitle: '-0.3s vs avg',
          icon: Icons.timer,
          iconColor: AppColors.tertiary,
          progress: 0.90,
          progressColor: AppColors.tertiary,
          bgIcon: Icons.schedule,
        ),
        _buildMetricCard(
          title: 'ESCALATION RATE',
          value: '4.2%',
          subtitle: 'NOMINAL',
          icon: Icons.analytics,
          iconColor: AppColors.primaryFixedDim,
          progress: 0.25,
          progressColor: AppColors.primaryFixedDim,
          bgIcon: Icons.trending_up,
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required double progress,
    required Color progressColor,
    required IconData bgIcon,
    Color? valueColor,
    Color? subtitleColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -16,
            bottom: -16,
            child: Opacity(
              opacity: 0.05,
              child: Icon(
                bgIcon,
                size: 100,
                color: AppColors.primaryContainer,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.outline,
                      letterSpacing: 0.5,
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
                  Icon(
                    icon,
                    size: 20,
                    color: iconColor,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: valueColor ?? AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: subtitleColor ?? AppColors.primaryContainer,
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsTable() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.view_list,
                      color: AppColors.primaryContainer,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Active Telemetry & Breach Feed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'SORT:',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.outline,
                        fontFamily: 'JetBrains Mono',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Risk Score (High-Low)',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColors.onSurface,
                              fontFamily: 'JetBrains Mono',
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: AppColors.onSurface, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(
                AppColors.surface.withOpacity(0.5),
              ),
              headingTextStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.outline,
                fontFamily: 'JetBrains Mono',
              ),
              dataTextStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.onSurface,
              ),
              columnSpacing: 16,
              horizontalMargin: 16,
              columns: const [
                DataColumn(label: Text('SEV / STATUS')),
                DataColumn(label: Text('TIMESTAMP')),
                DataColumn(label: Text('CAMERA ID')),
                DataColumn(label: Text('BREACH VECTOR')),
                DataColumn(label: Text('AI CONFIDENCE')),
                DataColumn(label: Text('RISK SCORE')),
                DataColumn(label: Text('ACTIONS'), numeric: true),
              ],
              rows: [
                _buildAlertRow(
                  severity: 'CRIT',
                  severityColor: AppColors.error,
                  timestamp: '14:22:09.41',
                  cameraId: 'CAM-AL-04',
                  breach: 'Unauth Perimeter Breach',
                  sector: 'Sector Alpha - Zone 3',
                  confidence: 98.4,
                  riskScore: 9.8,
                  isCritical: true,
                ),
                _buildAlertRow(
                  severity: 'HIGH',
                  severityColor: AppColors.error.withOpacity(0.8),
                  timestamp: '14:21:55.12',
                  cameraId: 'CAM-BT-12',
                  breach: 'Thermal Signature Spike',
                  sector: 'Sector Beta - Ridge North',
                  confidence: 94.1,
                  riskScore: 8.2,
                  isCritical: false,
                ),
                _buildAlertRow(
                  severity: 'MED',
                  severityColor: AppColors.tertiary,
                  timestamp: '14:19:02.88',
                  cameraId: 'CAM-GM-01',
                  breach: 'UAV Proximity Warning',
                  sector: 'Sector Gamma - Airspace 4',
                  confidence: 89.7,
                  riskScore: 6.5,
                  isCritical: false,
                ),
                _buildAlertRow(
                  severity: 'LOW',
                  severityColor: AppColors.outline,
                  timestamp: '14:15:40.10',
                  cameraId: 'CAM-DL-09',
                  breach: 'Sensor Array Calibration Drift',
                  sector: 'Sector Delta - Outpost 2',
                  confidence: 99.9,
                  riskScore: 2.1,
                  isCritical: false,
                ),
              ],
            ),
          ),
          // Pagination
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.3),
              border: const Border(top: BorderSide(color: AppColors.surfaceContainer)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'SHOWING 4 OF 142 ACTIVE ALERTS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.outline,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
                Row(
                  children: [
                    _buildPaginationButton('Prev'),
                    _buildPaginationButton('1', isActive: true),
                    _buildPaginationButton('2'),
                    _buildPaginationButton('3'),
                    _buildPaginationButton('Next'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildAlertRow({
    required String severity,
    required Color severityColor,
    required String timestamp,
    required String cameraId,
    required String breach,
    required String sector,
    required double confidence,
    required double riskScore,
    required bool isCritical,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Container(
                width: 8,
                height: 32,
                decoration: BoxDecoration(
                  color: severityColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: severityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  severity,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: severityColor,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            timestamp,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
              fontFamily: 'JetBrains Mono',
            ),
          ),
        ),
        DataCell(
          Text(
            cameraId,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryContainer,
              fontFamily: 'JetBrains Mono',
            ),
          ),
        ),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                breach,
                style: const TextStyle(fontSize: 14, color: AppColors.onSurface),
              ),
              Text(
                sector,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.outline,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              Text(
                '${confidence.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 64,
                height: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: confidence / 100,
                    backgroundColor: AppColors.surfaceContainerHigh,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCritical ? AppColors.primaryContainer : AppColors.tertiary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              Text(
                riskScore.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isCritical ? AppColors.error : AppColors.tertiary,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                isCritical ? Icons.local_fire_department : Icons.warning,
                size: 14,
                color: isCritical ? AppColors.error : AppColors.tertiary,
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: const Text(
                  'Dispatch',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(
                  Icons.volume_off,
                  size: 16,
                  color: AppColors.onSurfaceVariant,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(
                  Icons.download,
                  size: 16,
                  color: AppColors.onSurfaceVariant,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaginationButton(String label, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryContainer : AppColors.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: isActive ? AppColors.onPrimary : AppColors.onSurfaceVariant,
          fontFamily: 'JetBrains Mono',
        ),
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
      color: AppColors.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // Brand
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.onSurface),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 12),
                const KavachLogo(size: 48, padding: EdgeInsets.zero),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Navigation
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  _buildNavItem(Icons.grid_view, 'Command Center', false),
                  _buildNavItem(Icons.radar, 'Detection Engine', false),
                  _buildNavItem(Icons.directions_walk, 'AI Shadow & Trails', false),
                  _buildNavItem(Icons.search, 'Scene Search', false),
                  _buildNavItem(Icons.warning, 'Alerts & Risk', true),
                  _buildNavItem(Icons.satellite, 'Coverage Intel', false),
                  _buildNavItem(Icons.terrain, 'Terrain Models', false),
                  const Spacer(),
                  _buildNavItem(Icons.settings, 'Admin', false),
                ],
              ),
            ),
          ),
          // Status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'SECURE LINK ACTIVE',
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
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.8),
        border: const Border(bottom: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  border: Border.all(color: AppColors.outlineVariant),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.show_chart,
                      size: 16,
                      color: AppColors.primaryContainer,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'SYS PULSE: 99.4%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryContainer,
                        fontFamily: 'JetBrains Mono',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
            ],
          ),
        ],
      ),
    );
  }
}

class RightSidebar extends StatelessWidget {
  const RightSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // Sector Risk Matrix
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildRiskMatrix(),
                  const SizedBox(height: 24),
                  _buildLiveFeed(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskMatrix() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.radar,
                    color: AppColors.primaryContainer,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Sector Risk Matrix',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'REAL-TIME',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryContainer,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Continuous threat weighting across active territorial sectors.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          _buildSectorRisk(
            name: 'SECTOR ALPHA (NORTH)',
            status: 'CRITICAL',
            statusColor: AppColors.error,
            riskIndex: '9.4/10',
            units: '14',
            riskBlocks: 9,
            isCritical: true,
          ),
          const SizedBox(height: 12),
          _buildSectorRisk(
            name: 'SECTOR BETA (EAST)',
            status: 'ELEVATED',
            statusColor: AppColors.tertiary,
            riskIndex: '6.8/10',
            units: '8',
            riskBlocks: 7,
            isCritical: false,
          ),
          const SizedBox(height: 12),
          _buildSectorRisk(
            name: 'SECTOR GAMMA (SOUTH)',
            status: 'NOMINAL',
            statusColor: AppColors.primaryContainer,
            riskIndex: '3.2/10',
            units: '6',
            riskBlocks: 3,
            isCritical: false,
          ),
          const SizedBox(height: 12),
          _buildSectorRisk(
            name: 'SECTOR DELTA (WEST)',
            status: 'NOMINAL',
            statusColor: AppColors.primaryContainer,
            riskIndex: '2.1/10',
            units: '5',
            riskBlocks: 2,
            isCritical: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSectorRisk({
    required String name,
    required String status,
    required Color statusColor,
    required String riskIndex,
    required String units,
    required int riskBlocks,
    required bool isCritical,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Risk Index: $riskIndex',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.outline,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
              Text(
                'Active Units: $units',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.outline,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(10, (index) {
              final isFilled = index < riskBlocks;
              return Expanded(
                child: Container(
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: isFilled
                        ? isCritical
                            ? AppColors.error
                            : statusColor
                        : AppColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveFeed() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.videocam,
                    color: AppColors.primaryContainer,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Target Lock Preview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                    const SizedBox(width: 4),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.error,
                        fontFamily: 'JetBrains Mono',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 192,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuD1r-DgMa75mutjkyxkkmh5cL1ujvXRlm6f7knhdqENLqBUz-bDK_qW-UlApNtiwF2AK8OImf5u35DARjloaSKUc_DMS1fxsLwSJ2B7CrTg1suTaBWrsQUm61yMSs1KnHSwBbna6KKWsRsnp0yP1oN4JXSbodti6Qu-SBw5RaKvrj-29ri1U0QWyvaBVBGfgJ0XMgNmf7AICMiFUQL89167-LB13AOlFvSvIHhbc-_s9_B9uHDQ5RUg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.surfaceContainerLowest,
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.3],
                    ),
                  ),
                ),
                // HUD Overlays
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'CAM-AL-04 // 1080p60',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryContainer,
                        fontFamily: 'JetBrains Mono',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.2),
                      border: Border.all(color: AppColors.error.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'LOCK: 98.4%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.error,
                        fontFamily: 'JetBrains Mono',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'VECT: PERIMETER BREACH',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.onSurfaceVariant,
                            fontFamily: 'JetBrains Mono',
                          ),
                        ),
                        const Text(
                          'LAT: 32.793N',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryContainer,
                            fontFamily: 'JetBrains Mono',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bolt, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'DISPATCH UNIT',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'LOGS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onSurface,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}