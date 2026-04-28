import 'package:flutter/material.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import 'package:news_break/app/widgets/help_widgets.dart';

// ─── Data Model ────────────────────────────────────────────────────────────────

class JobListing {
  final String title;
  final String location;
  final String department;

  const JobListing({
    required this.title,
    required this.location,
    required this.department,
  });
}

// ─── Static Data ───────────────────────────────────────────────────────────────

const List<String> _departments = [
  'Engineering',
  'Internship Program',
  'Product and Design',
];

const List<String> _offices = [
  'Mountain view office',
];

const List<JobListing> _allJobs = [
  JobListing(title: 'AI Development Engineer', location: 'CA, USA', department: 'Engineering'),
  JobListing(title: 'AI Development Engineer', location: 'CA, USA', department: 'Engineering'),
  JobListing(title: 'AI Development Engineer', location: 'CA, USA', department: 'Product and Design'),
  JobListing(title: 'AI Development Engineer', location: 'CA, USA', department: 'Product and Design'),
  JobListing(title: 'Backend Engineer', location: 'CA, USA', department: 'Engineering'),
  JobListing(title: 'iOS Developer', location: 'CA, USA', department: 'Engineering'),
  JobListing(title: 'UX Designer', location: 'CA, USA', department: 'Product and Design'),
  JobListing(title: 'Software Intern', location: 'CA, USA', department: 'Internship Program'),
  JobListing(title: 'Product Manager', location: 'CA, USA', department: 'Product and Design'),
];

// ─── View ───────────────────────────────────────────────────────────────────────

class OpenPositionsView extends StatefulWidget {
  const OpenPositionsView({super.key});

  @override
  State<OpenPositionsView> createState() => _OpenPositionsViewState();
}

class _OpenPositionsViewState extends State<OpenPositionsView> {
  String? _selectedDepartment;
  String? _selectedOffice;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<JobListing> get _filteredJobs {
    return _allJobs.where((job) {
      final matchesDept =
          _selectedDepartment == null || job.department == _selectedDepartment;
      final matchesOffice = _selectedOffice == null; // extend if office per-job
      final matchesSearch = _searchQuery.isEmpty ||
          job.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          job.department.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesDept && matchesOffice && matchesSearch;
    }).toList();
  }

  Map<String, List<JobListing>> get _groupedJobs {
    final Map<String, List<JobListing>> grouped = {};
    for (final job in _filteredJobs) {
      grouped.putIfAbsent(job.department, () => []).add(job);
    }
    return grouped;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupedJobs;
    final totalJobs = _filteredJobs.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelpWidgets.helpAppBar('Help Center'),
      body: Column(
        children: [
          const HelpTabBar(),
          Expanded(
            child: ListView(
              children: [
                // ── Hero ──────────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Opening at newsBreak',
                        style: AppTextStyles.chart
                            .copyWith(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Lobortis ipsum urna egestas commodo ultrices pellentesque. Maecenas massa blandit posuere vel fermentum at imperdiet eu. Massa viverra arcu justo ante elementum ipsum sollicitudin iactus libero. Nisl duis nec mauris id vitae donec gravida.',
                        style: AppTextStyles.overline
                            .copyWith(color: const Color(0xFF6C6C6C)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── Search Bar ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Icon(Icons.search,
                            color: Color(0xFF9E9E9E), size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (v) =>
                                setState(() => _searchQuery = v),
                            style: AppTextStyles.caption
                                .copyWith(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'search',
                              hintStyle: AppTextStyles.caption
                                  .copyWith(color: const Color(0xFF9E9E9E)),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Department Dropdown ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Department',
                          style: AppTextStyles.caption
                              .copyWith(color: Colors.black54)),
                      const SizedBox(height: 4),
                      _buildDropdown(
                        value: _selectedDepartment,
                        items: _departments,
                        onChanged: (v) =>
                            setState(() => _selectedDepartment = v),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ── Office Dropdown ───────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Office',
                          style: AppTextStyles.caption
                              .copyWith(color: Colors.black54)),
                      const SizedBox(height: 4),
                      _buildDropdown(
                        value: _selectedOffice,
                        items: _offices,
                        onChanged: (v) =>
                            setState(() => _selectedOffice = v),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── Jobs Count ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '$totalJobs jobs',
                    style: AppTextStyles.chart
                        .copyWith(color: Colors.black, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Grouped Job Listings ──────────────────────────────────────
                if (grouped.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text('No jobs found.',
                          style: AppTextStyles.caption
                              .copyWith(color: Colors.black54)),
                    ),
                  )
                else
                  ...grouped.entries.map((entry) => _buildDepartmentGroup(
                    department: entry.key,
                    jobs: entry.value,
                  )),

                const SizedBox(height: 16),
                HelpWidgets.helpFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Dropdown Builder ──────────────────────────────────────────────────────────
  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text('Select',
              style: AppTextStyles.caption
                  .copyWith(color: const Color(0xFF9E9E9E))),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Colors.black54, size: 20),
          isExpanded: true,
          style:
          AppTextStyles.caption.copyWith(color: const Color(0xFF252F39)),
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text('Select',
                  style: AppTextStyles.caption
                      .copyWith(color: const Color(0xFF9E9E9E))),
            ),
            ...items.map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            )),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ── Department Group ──────────────────────────────────────────────────────────
  Widget _buildDepartmentGroup({
    required String department,
    required List<JobListing> jobs,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Department Header
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              department,
              style: AppTextStyles.chart.copyWith(
                color: AppColors.linkColor,
                fontSize: 15,
              ),
            ),
          ),

          // Job Tiles
          ...jobs.map((job) => _buildJobTile(job)),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Single Job Tile ───────────────────────────────────────────────────────────
  Widget _buildJobTile(JobListing job) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to job detail page
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: AppTextStyles.caption
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              job.location,
              style: AppTextStyles.caption
                  .copyWith(color: const Color(0xFF6C6C6C)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}