import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _nameController = TextEditingController(text: 'Amy');
  final _userNameController = TextEditingController(text: 'Amy');
  final _bioController = TextEditingController(text: 'Amy');
  final _websiteController = TextEditingController(text: 'www.sdfsf.com');
  final _emailController = TextEditingController(text: 'ab@gmail.com');

  String _selectedBirthYear = '12/12/2005';
  String _selectedGender = 'Female';

  static const List<String> _genders = [
    'Female',
    'Male',
    'Non-binary',
    'Prefer not to say',
  ];

  static final List<String> _years = List.generate(
    80,
        (i) => (1944 + i).toString(),
  );

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _bioController.dispose();
    _websiteController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios,
              color: Colors.white, size: 18),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: _showMoreOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Avatar
                  GestureDetector(
                    onTap: _showPhotoOptions,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.grey[800],
                          child: const Icon(Icons.person,
                              color: Colors.white, size: 40),
                        ),
                        const SizedBox(height: 8),
                        const Text('Edit Photo',
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Name
                  _inputField('Name', _nameController),
                  const SizedBox(height: 12),

                  // User Name
                  _inputField('User Name', _userNameController),
                  const SizedBox(height: 12),

                  // Bio
                  _inputField('Bio', _bioController),
                  const SizedBox(height: 12),

                  // Website
                  _inputField('Website', _websiteController),
                  const SizedBox(height: 12),

                  // Get content prompt
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Get content you\'ll really like! Tell us more.',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Email
                  _inputField('Email Address', _emailController,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 12),

                  // Birth year
                  _dropdownField(
                    label: 'Birth year',
                    value: _selectedBirthYear,
                    onTap: _showBirthYearPicker,
                  ),
                  const SizedBox(height: 12),

                  // Gender
                  _dropdownField(
                    label: 'Gender',
                    value: _selectedGender,
                    onTap: _showGenderPicker,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Save button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE57373),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Input field ──────────────────────────────
  Widget _inputField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  // ── Dropdown field ───────────────────────────
  Widget _dropdownField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 2),
                  Text(value,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down,
                color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  // ── Birth year picker ────────────────────────
  void _showBirthYearPicker() {
    String tempYear = _selectedBirthYear.split('/').last;
    final controller = FixedExtentScrollController(
      initialItem: _years.indexOf(tempYear).clamp(0, _years.length - 1),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: const Text('Birth Year',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center),
        content: SizedBox(
          height: 150,
          child: ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 40,
            perspective: 0.005,
            onSelectedItemChanged: (i) => tempYear = _years[i],
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (_, i) => Center(
                child: Text(
                  _years[i],
                  style: TextStyle(
                    color: i == _years.indexOf(tempYear)
                        ? Colors.white
                        : Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              childCount: _years.length,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              setState(() => _selectedBirthYear = tempYear);
              Navigator.pop(context);
            },
            child: const Text('Ok',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Gender picker ────────────────────────────
  void _showGenderPicker() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: const Text('Gender',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _genders
              .map((g) => Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => _selectedGender = g);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 12),
                  child: Text(g,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 15)),
                ),
              ),
              if (g != _genders.last)
                const Divider(color: Colors.white12, height: 1),
            ],
          ))
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  // ── Photo options ────────────────────────────
  void _showPhotoOptions() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: const Text('Choose your photo',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Take a picture',
                    style:
                    TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
            const Divider(color: Colors.white12, height: 1),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Choose from gallery',
                    style:
                    TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  // ── More options (3-dot) ─────────────────────
  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            // ✅ এটা যোগ করুন
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.white),
              title: const Text('About this profile',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              onTap: () {
                Navigator.pop(context);
                _showAboutProfile();
              },
            ),
            const Divider(color: Colors.white12, height: 1),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete account',
                  style: TextStyle(color: Colors.red, fontSize: 15)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirm();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── Delete confirm dialog ────────────────────
  void _showDeleteConfirm() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: const Text('Are you sure you want to delete account?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600)),
        content: const Text(
          'Deleting your account is permanent and means you won\'t be able to recover all your data, including saved articles, comments and followed medias.',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: delete account logic
            },
            child: const Text('Delete',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // ── About profile dialog ─────────────────────
  void _showAboutProfile() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        title: const Text('About this profile',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _nameController.text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white12, height: 1),
            const SizedBox(height: 16),
            const Text('Joined',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            const Text('Since april 2024',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 16),
            const Divider(color: Colors.white12, height: 1),
            const SizedBox(height: 12),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                    color: Colors.grey, fontSize: 12, height: 1.5),
                children: [
                  TextSpan(
                      text: 'All content is required to comply with our '),
                  TextSpan(
                    text: 'Community Standards',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  TextSpan(
                      text:
                      '. Please help us keep ous community safe by reporting any violations.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}