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
      title: 'IBVAP - System Admin',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF0F131C),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const SystemAdminView(),
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
  static const Color primaryFixed = Color(0xFF9CF0FF);
  static const Color primaryFixedDim = Color(0xFF00DAF3);
  static const Color onPrimary = Color(0xFF00363D);
  static const Color onPrimaryContainer = Color(0xFF00626E);
  static const Color error = Color(0xFFFFB4AB);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color outline = Color(0xFF849396);
  static const Color outlineVariant = Color(0xFF3B494C);
  static const Color secondary = Color(0xFFC1C6D9);
  static const Color tertiary = Color(0xFFE4EDFF);
  static const Color surfaceTint = Color(0xFF00DAF3);
  static const Color onError = Color(0xFF690005);
}

class SystemAdminView extends StatefulWidget {
  const SystemAdminView({super.key});

  @override
  State<SystemAdminView> createState() => _SystemAdminViewState();
}

class _SystemAdminViewState extends State<SystemAdminView> {
  bool _isCameraModalVisible = false;
  bool _isBulkModalVisible = false;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _cameraIdController = TextEditingController();
  final TextEditingController _rtspController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  String _selectedSector = 'Sector 1 - Northern Wall';
  String _selectedModel = 'PTZ Thermal';

  final List<Map<String, dynamic>> _cameras = [
    {
      'id': 'CAM-SEC-092',
      'location': 'Sector 4 - Alpha Ridge',
      'coords': '34.1022° N, 74.2011° E',
      'ip': '10.142.88.15',
      'status': 'ONLINE',
      'statusColor': Color(0xFF34D399),
      'model': 'PTZ Thermal',
    },
    {
      'id': 'CAM-SEC-104',
      'location': 'Sector 2 - Delta Pass',
      'coords': '33.9102° N, 75.0210° E',
      'ip': '10.142.88.42',
      'status': 'ONLINE',
      'statusColor': Color(0xFF34D399),
      'model': 'Fixed Thermal',
    },
    {
      'id': 'CAM-SEC-119',
      'location': 'Sector 1 - Northern Wall',
      'coords': '35.0122° N, 73.8911° E',
      'ip': '10.142.89.04',
      'status': 'OFFLINE',
      'statusColor': AppColors.error,
      'model': 'PTZ Thermal',
    },
    {
      'id': 'CAM-SEC-150',
      'location': 'Sector 5 - Echo Valley',
      'coords': '32.8810° N, 76.1042° E',
      'ip': '10.142.90.11',
      'status': 'ONLINE',
      'statusColor': Color(0xFF34D399),
      'model': 'Fixed Thermal',
    },
  ];

  final List<String> sectors = [
    'Sector 1 - Northern Wall',
    'Sector 2 - Delta Pass',
    'Sector 3 - Western Ridge',
    'Sector 4 - Alpha Ridge',
    'Sector 5 - Echo Valley',
  ];

  final List<String> models = [
    'PTZ Thermal',
    'Fixed Thermal',
    'Optical 4K Zoom',
  ];

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
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header & Action Bar
                        _buildHeader(),
                        const SizedBox(height: 32),
                        // Quick Metrics Grid
                        _buildMetricsGrid(),
                        const SizedBox(height: 32),
                        // Camera Registry Table
                        _buildCameraRegistry(),
                        const SizedBox(height: 32),
                        // System Settings Cards
                        _buildSystemSettings(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Modals are rendered above the page content when their flags are active.
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SYSTEM ADMIN & CAMERA REGISTRY',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Manage global optical sensors, edge-computing nodes, and security clearances across all active sectors.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        Row(
          children: [
            // Diagnostics Pulse Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                border: Border.all(color: AppColors.outlineVariant),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF34D399),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'DIAGNOSTICS: NOMINAL',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF34D399),
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Bulk Import Button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.onSurface,
                side: const BorderSide(color: AppColors.outlineVariant),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                setState(() {
                  _isBulkModalVisible = true;
                });
              },
              icon: const Icon(Icons.upload_file, size: 18, color: AppColors.primary),
              label: const Text('Bulk Import (CSV)'),
            ),
            const SizedBox(width: 12),
            // Add Camera Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.onPrimaryContainer,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {
                setState(() {
                  _isCameraModalVisible = true;
                });
              },
              icon: const Icon(Icons.add_circle, size: 18),
              label: const Text('Add Camera'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.9,
      children: [
        _buildMetricCard(
          title: 'Total Nodes Online',
          value: '1,482',
          subtitle: '98.4% SYNC',
          progress: 0.984,
          progressColor: AppColors.primary,
          icon: Icons.show_chart,
        ),
        _buildMetricCard(
          title: 'PTZ Thermal Units',
          value: '640',
          subtitle: 'ACTIVE CALIBRATION',
          progress: 0.85,
          progressColor: AppColors.primary,
          icon: Icons.thermostat,
        ),
        _buildMetricCard(
          title: 'Network Latency',
          value: '14.2ms',
          subtitle: 'STABLE LINK',
          progress: 0.92,
          progressColor: const Color(0xFF34D399),
          icon: Icons.speed,
          valueColor: const Color(0xFF34D399),
        ),
        _buildMetricCard(
          title: 'Bandwidth Consumption',
          value: '4.8 TB/s',
          subtitle: '62% CAPACITY',
          progress: 0.62,
          progressColor: const Color(0xFFFBBF24),
          icon: Icons.wifi,
          valueColor: AppColors.secondary,
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required double progress,
    required Color progressColor,
    required IconData icon,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
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
              Icon(icon, size: 20, color: AppColors.primary),
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
                  color: valueColor ?? AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: valueColor ?? AppColors.primary,
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
    );
  }

  Widget _buildCameraRegistry() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.videocam,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Active Camera Registry',
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
                  // Search
                  Container(
                    width: 256,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        color: AppColors.onSurface,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Filter by ID, IP or Sector...',
                        hintStyle: const TextStyle(
                          color: AppColors.outline,
                          fontSize: 13,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 16,
                          color: AppColors.outline,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Filter Button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.filter_list,
                          size: 16,
                          color: AppColors.onSurface,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(
                AppColors.surfaceContainerHigh.withOpacity(0.3),
              ),
              headingTextStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.outline,
                letterSpacing: 0.5,
                fontFamily: 'JetBrains Mono',
              ),
              dataTextStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.onSurface,
              ),
              columnSpacing: 24,
              horizontalMargin: 16,
              columns: const [
                DataColumn(label: Text('S.No')),
                DataColumn(label: Text('Camera ID')),
                DataColumn(label: Text('Location / Coordinates')),
                DataColumn(label: Text('IP Address')),
                DataColumn(label: Text('Stream Status')),
                DataColumn(label: Text('Model Type')),
                DataColumn(label: Text('Actions'), numeric: true),
              ],
              rows: _cameras.asMap().entries.map((entry) {
                final index = entry.key;
                final camera = entry.value;
                final isOnline = camera['status'] == 'ONLINE';
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        '${(index + 1).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: AppColors.outline,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        camera['id'],
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ),
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            camera['location'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            camera['coords'],
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
                      Text(
                        camera['ip'],
                        style: const TextStyle(
                          color: AppColors.secondary,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: isOnline
                              ? const Color(0xFF34D399).withOpacity(0.1)
                              : AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: isOnline
                                    ? const Color(0xFF34D399)
                                    : AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              camera['status'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: isOnline
                                    ? const Color(0xFF34D399)
                                    : AppColors.error,
                                fontFamily: 'JetBrains Mono',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          camera['model'],
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.onSurfaceVariant,
                            fontFamily: 'JetBrains Mono',
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                              color: AppColors.onSurfaceVariant,
                            ),
                            onPressed: () {
                              setState(() {
                                _isCameraModalVisible = true;
                              });
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(
                              Icons.bolt,
                              size: 18,
                              color: AppColors.onSurfaceVariant,
                            ),
                            onPressed: () {
                              _showSnackbar(
                                'Initiating ping and RTSP handshake for ${camera['id']}... Status: OK (12ms)',
                              );
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 18,
                              color: AppColors.onSurfaceVariant,
                            ),
                            onPressed: () {
                              _showDeleteConfirmation(index);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemSettings() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      childAspectRatio: 1.1,
      children: [
        _buildSettingsCard(
          icon: Icons.psychology,
          title: 'AI Model Weights',
          subtitle: 'Configure inference weights for automated human, vehicle, and drone intrusion detection models.',
          version: 'v4.8.2 ACTIVE',
          versionColor: const Color(0xFF34D399),
          items: [
            _buildModelItem('Thermal Intrusion Model (YOLOv9-B)', '94.8% ACC'),
            _buildModelItem('Low-Light Optical Tracker', '91.2% ACC'),
          ],
          buttonText: 'Update Weights Repository',
          buttonIcon: Icons.update,
        ),
        _buildSettingsCard(
          icon: Icons.storage,
          title: 'Retention Policies',
          subtitle: 'Manage archival lifecycle, evidence lockers, and high-definition stream ring buffers.',
          version: 'AUTO-ARCHIVE',
          versionColor: AppColors.primary,
          items: [
            _buildRetentionItem('Standard Telemetry', 'Logs, radar tracks, metadata', '90 Days'),
            _buildRetentionItem('Flagged Alert Buffer', 'High-res clips of breaches', '365 Days'),
          ],
          buttonText: 'Modify Storage Rules',
          buttonIcon: Icons.rule,
        ),
        _buildSettingsCard(
          icon: Icons.admin_panel_settings,
          title: 'Operator Access Control',
          subtitle: 'Enforce role-based security clearances, multi-factor authentication, and biometric overrides.',
          version: 'SECURE LDAP',
          versionColor: const Color(0xFF34D399),
          items: [
            _buildAccessItem('Level 4 - Command Officers', '12 Active', const Color(0xFF34D399)),
            _buildAccessItem('Level 2 - Sector Operators', '48 Active', AppColors.primary),
            _buildAccessItem('Level 1 - External Audit', '3 Active', AppColors.outline),
          ],
          buttonText: 'Manage Permissions',
          buttonIcon: Icons.group,
        ),
      ],
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String version,
    required Color versionColor,
    required List<Widget> items,
    required String buttonText,
    required IconData buttonIcon,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, size: 24, color: AppColors.primary),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: versionColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      version,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: versionColor,
                        fontFamily: 'JetBrains Mono',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              ...items,
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.onSurface,
                side: const BorderSide(color: AppColors.outlineVariant),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              onPressed: () {},
              icon: Icon(buttonIcon, size: 18),
              label: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModelItem(String label, String accuracy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.onSurfaceVariant,
                fontFamily: 'JetBrains Mono',
              ),
            ),
            Text(
              accuracy,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
                fontFamily: 'JetBrains Mono',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            widthFactor: double.parse(accuracy.replaceAll('% ACC', '')) / 100,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildRetentionItem(String title, String subtitle, String duration) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.outline,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
            ],
          ),
          Text(
            duration,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
              fontFamily: 'JetBrains Mono',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessItem(String role, String count, Color dotColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                role,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          Text(
            count,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.outline,
              fontFamily: 'JetBrains Mono',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraModal() {
    if (!_isCameraModalVisible) return const SizedBox.shrink();

    return Stack(
      children: [
        // Backdrop
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isCameraModalVisible = false;
              });
            },
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ),
        // Modal
        Center(
          child: Container(
            width: 512,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              border: Border.all(color: AppColors.outlineVariant),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.videocam,
                            size: 20,
                            color: AppColors.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Configure Camera Node',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.outline,
                      ),
                      onPressed: () {
                        setState(() {
                          _isCameraModalVisible = false;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Form
                Column(
                  children: [
                    _buildFormField(
                      label: 'Camera Name / ID',
                      controller: _cameraIdController,
                      hint: 'e.g. CAM-SEC-205',
                    ),
                    const SizedBox(height: 12),
                    _buildFormField(
                      label: 'RTSP Stream URL',
                      controller: _rtspController,
                      hint: 'rtsp://10.142.xx.xx:554/stream1',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFormField(
                            label: 'GPS Latitude',
                            controller: _latController,
                            hint: '34.1022° N',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            label: 'GPS Longitude',
                            controller: _lngController,
                            hint: '74.2011° E',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Sector Assignment',
                            value: _selectedSector,
                            items: sectors,
                            onChanged: (value) {
                              setState(() {
                                _selectedSector = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Model Type',
                            value: _selectedModel,
                            items: models,
                            onChanged: (value) {
                              setState(() {
                                _selectedModel = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isCameraModalVisible = false;
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.onSurface,
                      ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: AppColors.onPrimaryContainer,
                      ),
                      onPressed: () {
                        _showSnackbar('Camera node successfully deployed to network mesh.');
                        setState(() {
                          _isCameraModalVisible = false;
                        });
                      },
                      child: const Text('Deploy Node'),
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

  Widget _buildBulkImportModal() {
    if (!_isBulkModalVisible) return const SizedBox.shrink();

    return Stack(
      children: [
        // Backdrop
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isBulkModalVisible = false;
              });
            },
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ),
        // Modal
        Center(
          child: Container(
            width: 448,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              border: Border.all(color: AppColors.outlineVariant),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.upload_file,
                            size: 20,
                            color: AppColors.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Bulk Import Cameras (CSV)',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.outline,
                      ),
                      onPressed: () {
                        setState(() {
                          _isBulkModalVisible = false;
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Drop Zone
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh.withOpacity(0.3),
                    border: Border.all(color: AppColors.outlineVariant, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.cloud_upload,
                        size: 36,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.onSurface,
                          ),
                          children: [
                            TextSpan(text: 'Drag & Drop CSV file here or '),
                            TextSpan(
                              text: 'browse',
                              style: TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Expected format: ID, IP, Lat, Lng, Sector, Model',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.outline,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isBulkModalVisible = false;
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.onSurface,
                      ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: AppColors.onPrimaryContainer,
                      ),
                      onPressed: () {
                        _showSnackbar('CSV file uploaded and parsed successfully.');
                        setState(() {
                          _isBulkModalVisible = false;
                        });
                      },
                      child: const Text('Upload & Parse'),
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

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.outline,
            letterSpacing: 0.5,
            fontFamily: 'JetBrains Mono',
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          style: const TextStyle(
            color: AppColors.onSurface,
            fontSize: 13,
            fontFamily: 'JetBrains Mono',
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.outline,
              fontSize: 13,
              fontFamily: 'JetBrains Mono',
            ),
            filled: true,
            fillColor: AppColors.surfaceContainerHigh,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.outline,
            letterSpacing: 0.5,
            fontFamily: 'JetBrains Mono',
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              style: const TextStyle(
                color: AppColors.onSurface,
                fontSize: 13,
                fontFamily: 'JetBrains Mono',
              ),
              dropdownColor: AppColors.surfaceContainerHigh,
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.surfaceContainerHigh,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceContainerLow,
        title: const Text(
          'Decommission Camera Node?',
          style: TextStyle(color: AppColors.onSurface),
        ),
        content: const Text(
          'Are you sure you want to decommission this camera node?',
          style: TextStyle(color: AppColors.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cameras.removeAt(index);
              });
              Navigator.pop(context);
              _showSnackbar('Camera node decommissioned successfully.');
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: const Text('Remove'),
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
      color: AppColors.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // Brand
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
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
                  _buildNavItem(Icons.warning, 'Alerts & Risk', false),
                  _buildNavItem(Icons.satellite, 'Coverage Intel', false),
                  _buildNavItem(Icons.terrain, 'Terrain Models', false),
                  const Spacer(),
                  _buildNavItem(Icons.settings, 'Admin', true),
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
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'SYS PULSE: 99.4%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
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
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person,
                  size: 18,
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}