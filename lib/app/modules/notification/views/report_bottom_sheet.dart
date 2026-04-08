import 'package:flutter/material.dart';

class ReportBottomSheet extends StatefulWidget {
  const ReportBottomSheet({super.key});

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  // Steps: 0 = select reason, 1 = sub-reason, 2 = confirm, 3 = success
  int _step = 0;
  String? _selectedReason;
  String? _selectedSubReason;

  static const List<String> _reasons = [
    'Hate or Harassment',
    'Sensitive or Disturbing Content',
    'Safety',
    'False or Misleading Content',
    'Fraudulent Behavior and spam',
    'Commercial and Promotional Content',
    'Content Rights',
    'Readability and Relevance',
    'Video Quality Issues',
    'Other',
  ];

  static const Map<String, List<String>> _subReasons = {
    'Hate or Harassment': ['Hateful Behavior', 'Harassment and Bullying'],
    'Sensitive or Disturbing Content': ['Graphic Violence', 'Adult Content', 'Self-Harm'],
    'Safety': ['Dangerous Activities', 'Threat or Violence'],
    'False or Misleading Content': ['Misinformation', 'Fake News', 'Satire'],
    'Fraudulent Behavior and spam': ['Scam', 'Spam', 'Fake Account'],
    'Commercial and Promotional Content': ['Unauthorized Ads', 'Misleading Promotion'],
    'Content Rights': ['Copyright Violation', 'Privacy Violation'],
    'Readability and Relevance': ['Off-topic', 'Low Quality'],
    'Video Quality Issues': ['Poor Resolution', 'Audio Issues'],
    'Other': ['Other'],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: _buildStep(),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _buildSelectReason();
      case 1:
        return _buildSubReason();
      case 2:
        return _buildConfirm();
      case 3:
        return _buildSuccess();
      default:
        return _buildSelectReason();
    }
  }

  // Step 0 — Select a reason
  Widget _buildSelectReason() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader('Select a reason', showBack: false),
        const Divider(color: Colors.white12, height: 1),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _reasons.length,
          itemBuilder: (_, i) => RadioListTile<String>(
            value: _reasons[i],
            groupValue: _selectedReason,
            onChanged: (val) => setState(() => _selectedReason = val),
            title: Text(_reasons[i],
                style: const TextStyle(color: Colors.white, fontSize: 14)),
            activeColor: Colors.white,
            dense: true,
          ),
        ),
        _buildButtons(
          onCancel: () => Navigator.pop(context),
          onNext: _selectedReason == null
              ? null
              : () => setState(() => _step = 1),
          nextLabel: 'Next',
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Step 1 — Sub reason
  Widget _buildSubReason() {
    final subs = _subReasons[_selectedReason] ?? ['Other'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader('How is it $_selectedReason', showBack: true,
            onBack: () => setState(() => _step = 0)),
        const Divider(color: Colors.white12, height: 1),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subs.length,
          itemBuilder: (_, i) => RadioListTile<String>(
            value: subs[i],
            groupValue: _selectedSubReason,
            onChanged: (val) => setState(() => _selectedSubReason = val),
            title: Text(subs[i],
                style: const TextStyle(color: Colors.white, fontSize: 14)),
            activeColor: Colors.white,
            dense: true,
          ),
        ),
        _buildButtons(
          onCancel: () => Navigator.pop(context),
          onNext: _selectedSubReason == null
              ? null
              : () => setState(() => _step = 2),
          nextLabel: 'Next',
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Step 2 — Confirm
  Widget _buildConfirm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader('You are about to submit a report',
            showBack: true, onBack: () => setState(() => _step = 1)),
        const Divider(color: Colors.white12, height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'We only remove content that goes against our community standard. Review your report details below.',
                style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 16),
              _infoField('Why are you reporting this?', _selectedReason ?? ''),
              const SizedBox(height: 12),
              _infoField('How is it $_selectedReason?', _selectedSubReason ?? ''),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => setState(() => _step = 3),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Submit',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // Step 3 — Success
  Widget _buildSuccess() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: const Icon(Icons.check, color: Colors.green, size: 28),
          ),
          const SizedBox(height: 16),
          const Text(
            'Thanx for reporting this',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Done',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildHeader(String title,
      {required bool showBack, VoidCallback? onBack}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          if (showBack)
            GestureDetector(
              onTap: onBack,
              child: const Icon(Icons.arrow_back_ios,
                  color: Colors.white, size: 18),
            )
          else
            const SizedBox(width: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons({
    required VoidCallback onCancel,
    required VoidCallback? onNext,
    required String nextLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white38),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                onNext != null ? Colors.white : Colors.white24,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(nextLabel,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ],
    );
  }
}