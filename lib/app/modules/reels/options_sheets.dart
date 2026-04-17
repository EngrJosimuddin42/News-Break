import 'package:flutter/material.dart';

// ── Reels Dot Menu Sheet ─────────────────────
class ReelsOptionsSheet extends StatelessWidget {
  const ReelsOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Card 1
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _optionTile(
                    icon: Icons.share_outlined,
                    iconColor: Colors.white,
                    label: 'Share',
                    onTap: () => Navigator.pop(context),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  _optionTile(
                    icon: Icons.bookmark_border,
                    iconColor: Colors.white,
                    label: 'Save',
                    onTap: () => Navigator.pop(context),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  _optionTile(
                    icon: Icons.timer_off_outlined,
                    iconColor: Colors.white,
                    label: 'Show less from author: Viral Vibes',
                    onTap: () => Navigator.pop(context),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  _optionTile(
                    icon: Icons.flag_outlined,
                    iconColor: Colors.red,
                    label: 'Report',
                    labelColor: Colors.red,
                    trailing: const Icon(Icons.chevron_right,
                        color: Colors.white38, size: 18),
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const ReelsReportSheet(),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Card 2 — Ask/request
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(14),
              ),
              child: _optionTile(
                icon: Icons.auto_fix_high,
                iconColor: Colors.blueAccent,
                label: 'Ask/request/report anything',
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionTile({
    required IconData icon,
    required Color iconColor,
    required String label,
    Color labelColor = Colors.white,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(label,
          style: TextStyle(color: labelColor, fontSize: 14)),
      trailing: trailing,
      onTap: onTap,
      dense: true,
    );
  }
}

// ── Reels Report Sheet ───────────────────────
class ReelsReportSheet extends StatefulWidget {
  const ReelsReportSheet({super.key});

  @override
  State<ReelsReportSheet> createState() => _ReelsReportSheetState();
}

class _ReelsReportSheetState extends State<ReelsReportSheet> {
  // 0=select reason, 1=success
  int _step = 0;
  String? _selectedReason;

  static const List<String> _reasons = [
    'Abusive or hateful',
    'Misleading or spam',
    'Violence or gory',
    'Sexual Content',
    'Minor safety',
    'Dangerous or criminal',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: _step == 0 ? _buildSelectReason() : _buildSuccess(),
    );
  }

  Widget _buildSelectReason() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios,
                    color: Colors.white, size: 18),
              ),
              const Expanded(
                child: Text('Report',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close,
                    color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.white12, height: 1),

        // Reasons
        ..._reasons.map((reason) => RadioListTile<String>(
          value: reason,
          groupValue: _selectedReason,
          onChanged: (val) =>
              setState(() => _selectedReason = val),
          title: Text(reason,
              style: const TextStyle(
                  color: Colors.white, fontSize: 14)),
          activeColor: Colors.white,
          dense: true,
        )),

        // Infringing my rights
        ListTile(
          title: const Text('Infringing my rights',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          trailing: const Icon(Icons.chevron_right,
              color: Colors.white38, size: 18),
          onTap: () {
            Navigator.pop(context);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const ReelsInfringingSheet(),
            );
          },
          dense: true,
        ),

        const Divider(color: Colors.white12, height: 1),

        // Buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white38),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _selectedReason == null
                      ? null
                      : () => setState(() => _step = 1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedReason != null
                        ? Colors.white
                        : Colors.white24,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Submit',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuccess() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: const Icon(Icons.check,
                color: Colors.green, size: 28),
          ),
          const SizedBox(height: 16),
          const Text('Thanx for reporting this',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Done',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15)),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ── Infringing My Rights Sheet ───────────────
class ReelsInfringingSheet extends StatelessWidget {
  const ReelsInfringingSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 18),
                ),
                const Expanded(
                  child: Text('Report video',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close,
                      color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Infringing my rights',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 13, height: 1.5),
                    children: [
                      const TextSpan(text: 'Visit the '),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text('help center',
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 13)),
                        ),
                      ),
                      const TextSpan(
                          text:
                          ' for more information to submit a copyright infringement notice.'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Open Help Center',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}