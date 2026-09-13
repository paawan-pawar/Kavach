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
      title: 'IBVAP - Scene Search',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF0F131C),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const IntelligenceSearchView(),
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
  static const Color secondary = Color(0xFFC1C6D9);
  static const Color secondaryContainer = Color(0xFF434959);
}

class IntelligenceSearchView extends StatefulWidget {
  const IntelligenceSearchView({super.key});

  @override
  State<IntelligenceSearchView> createState() => _IntelligenceSearchViewState();
}

class _IntelligenceSearchViewState extends State<IntelligenceSearchView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.background,
                    child: Column(
                      children: [
                        // Search Header Area
                        _buildSearchHeader(),
                        const SizedBox(height: 16),
                        // Main Content (Results + Side Panel)
                        Expanded(
                          child: Row(
                            children: [
                              // Results Gallery
                              Expanded(
                                child: _buildResultsGallery(),
                              ),
                              const SizedBox(width: 24),
                              // Side Panel (Search History) - only on large screens
                              if (MediaQuery.of(context).size.width > 1200)
                                _buildSearchHistory(),
                            ],
                          ),
                        ),
                        // AI Suggested Searches (Bottom pinned)
                        _buildAISuggestions(),
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

  Widget _buildSearchHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Stack(
            children: [
              TextField(
                controller: _searchController,
                style: const TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
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
                    borderSide: const BorderSide(color: AppColors.primaryContainer, width: 1),
                  ),
                  hintText: 'Describe what you need... e.g., "Find all red vehicles near Gate 2 between 6-8 AM"',
                  hintStyle: const TextStyle(
                    color: AppColors.outlineVariant,
                    fontSize: 16,
                  ),
                  prefixIcon: const Icon(
                    Icons.manage_search,
                    color: AppColors.primaryFixedDim,
                    size: 28,
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 56),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: AppColors.surfaceContainerLowest,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _searchQuery = _searchController.text;
                        });
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search, size: 18),
                          SizedBox(width: 4),
                          Text(
                            'INITIATE',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(minWidth: 120),
                ),
                onSubmitted: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const Text(
                'Filters:',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 0.5,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
              const SizedBox(width: 8),
              _buildFilterChip('All', true),
              _buildFilterChip('People', false),
              _buildFilterChip('Vehicles', false),
              _buildFilterChip('Faces', false),
              _buildFilterChip('Plates', false),
              Container(
                width: 1,
                height: 16,
                color: AppColors.outlineVariant,
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              _buildFilterChipWithIcon(Icons.calendar_today, 'Yesterday', false),
              _buildFilterChipWithIcon(Icons.calendar_month, 'This Week', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: isActive ? AppColors.surfaceContainerHigh : AppColors.surfaceContainer,
          foregroundColor: isActive ? AppColors.primaryContainer : AppColors.onSurfaceVariant,
          side: BorderSide(
            color: isActive ? AppColors.primaryContainer : AppColors.outlineVariant,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChipWithIcon(IconData icon, String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: AppColors.surfaceContainer,
          foregroundColor: AppColors.onSurfaceVariant,
          side: const BorderSide(color: AppColors.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsGallery() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Intel Results',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: AppColors.outlineVariant),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '47 MATCHES DETECTED',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryFixedDim,
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Masonry Grid
          Expanded(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 1;
                  if (constraints.maxWidth > 500) crossAxisCount = 2;
                  if (constraints.maxWidth > 800) crossAxisCount = 3;
                  if (constraints.maxWidth > 1100) crossAxisCount = 4;

                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                    children: const [
                      ResultCard(
                        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCJLJ_FKU-ODGJHHi0p-dLq-Ys7Y-mVFButEdng952VKCZYUNbQG2a9_6Rz2JJAp4KXkuAw8OG5LEV_KAuoQuwWRUkk_mLR0MruFnmyDzSRs-vG3cn3HNEPnnjTX20drDKun7bT7xdW9PT6dbhMY9qPiaDaiUdG3mqQfm2bvN9TB2gNKRzW60eVrGivEdjxT0drjrRbVxla442d4VIn6XuO254qhiD8o23_yUYQQeLWuh1Yor7oFFws',
                        title: 'Red SUV Detected',
                        time: '06:42:15 AM - Today',
                        location: 'CAM-G2-04',
                        match: '98% Match',
                        tag: 'Vehicle',
                        tagColor: AppColors.primaryContainer,
                        height: 160,
                      ),
                      ResultCard(
                        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBsPp-tlGQ6HteaIwBS0gzMZM9I3aQw_P-j2buFMiY8-AdnjLlr7SdIfDojqAQwK-06vGmNi5bR0VGwZrmBEeoFdxSWGtADawdaQPnETEwdKEpg0keql7Y7ib1HcvkQmKMiEi1XJnDkN8TsOK0t3ee0m8a90YQc6Bt81CqacA96ckEd7cy876AMRTwBG5sbUzFF3ulXtMNlC--v0_1mdeiwHihvMyHXSJSpPfszBmJhLdu18gFiX3Nr',
                        title: 'Unidentified Individual',
                        time: '07:15:02 AM - Today',
                        location: 'CAM-P1-12',
                        match: '92% Match',
                        tag: 'Person',
                        tagColor: AppColors.secondary,
                        height: 192,
                      ),
                      ResultCard(
                        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA3Uzg6-JBJrPYEfFUnMkjurQngdGg2ImQZ9SWc8MntIslb_3hZacfVw9UYqfh7CVClVmmbjlF54ad9VWUrOtO1vaLfaPeDuCUYi3iF5it45dx6ETDA4kymDfumvC8X8a3z0cg8eHtPpt3M10Mz9oudi1GK0dYfG7iDWhml7ZhtQVU3J790EcV-U4f9Xz-uW9kEtVHQkwAySnY8-rVzNwrnTWlMXWqh3qgxo7Ogv9QPkrT4Hz0fDPkl',
                        title: 'Partial Red Vehicle',
                        time: '06:58:33 AM - Today',
                        location: 'CAM-G2-05',
                        match: '88% Match',
                        tag: 'Vehicle',
                        tagColor: AppColors.primaryContainer,
                        height: 128,
                      ),
                      ResultCard(
                        imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDxtsDDwWEZcgnMtot_LogOBHDtWLHEpTlR8sk-UHh6p3vbSjhLAx4eWtANO1_eYluwdmNc4ljX_GYlCVU6ug_dIhSA0KG5U-8ALVn2sN0PmG8Y7nSoMl54loxFydyjF3e8cnzFz8fGy7w41EVnweR8h85ZUCB8PtbIuXF8YSP_XfcA7n8Qq17MVbuHoM4buzXZNRfO7FqS1hLQ2CDKOc76ef_9hweOyko5Ub8UFLsOHAbw14f_S4qW',
                        title: 'Departing Vehicle (Red)',
                        time: '07:45:10 AM - Today',
                        location: 'CAM-G2-01',
                        match: '75% Match',
                        tag: 'Vehicle',
                        tagColor: AppColors.primaryContainer,
                        height: 176,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHistory() {
    return Container(
      width: 288,
      decoration: BoxDecoration(
        color: const Color(0xFF121826),
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.outlineVariant),
              ),
              color: AppColors.surfaceContainerHigh,
            ),
            child: Row(
              children: [
                const Icon(Icons.history, color: AppColors.onSurfaceVariant, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Search History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                _buildHistoryItem(
                  '"Find all red vehicles near Gate 2 between 6-8 AM"',
                  'Today, 08:12 AM',
                ),
                _buildHistoryItem(
                  '"People carrying backpacks in Sector 4"',
                  'Yesterday, 22:45 PM',
                ),
                _buildHistoryItem(
                  '"Show me white vans loitering over 10 mins"',
                  'Oct 24, 14:30 PM',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String query, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border(
          left: BorderSide(color: Colors.transparent, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            query,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
              fontFamily: 'JetBrains Mono',
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.outline,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                size: 14,
                color: AppColors.outline,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAISuggestions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.9),
        border: const Border(top: BorderSide(color: AppColors.outlineVariant)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.auto_awesome,
            color: AppColors.primaryContainer,
            size: 20,
          ),
          const SizedBox(width: 12),
          const Text(
            'AI Suggestions:',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.5,
              fontFamily: 'JetBrains Mono',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildSuggestionChip('"Track this vehicle across all zones"'),
                  const SizedBox(width: 8),
                  _buildSuggestionChip('"Identify license plate variations"'),
                  const SizedBox(width: 8),
                  _buildSuggestionChip('"Show similar anomalies yesterday"'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF121826),
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.onSurface,
          fontFamily: 'Inter',
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
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: AppColors.outlineVariant),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.monitor_heart,
                      color: AppColors.primaryFixedDim,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'SYS: NOMINAL',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryFixedDim,
                        fontFamily: 'JetBrains Mono',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.notifications_none, color: AppColors.onSurfaceVariant),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
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
                  _buildNavItem(Icons.query_stats, 'AI Shadow & Trails', false),
                  _buildNavItem(Icons.search, 'Scene Search', true),
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

class ResultCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String time;
  final String location;
  final String match;
  final String tag;
  final Color tagColor;
  final double height;

  const ResultCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.time,
    required this.location,
    required this.match,
    required this.tag,
    required this.tagColor,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF121826),
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: height,
            width: double.infinity,
            color: Colors.black,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
                    ),
                  ),
                ),
                // Match badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.radar,
                          color: AppColors.primaryContainer,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          match,
                          style: const TextStyle(
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
                // Location badge
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      location,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurface,
                        fontFamily: 'JetBrains Mono',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onSurfaceVariant,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: tagColor.withOpacity(0.1),
                    border: Border(left: BorderSide(color: tagColor, width: 2)),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: tagColor,
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(color: AppColors.primaryFixedDim),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_arrow,
                          color: AppColors.primaryFixedDim,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Play from here',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryFixedDim,
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