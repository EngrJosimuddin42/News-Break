import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';

import '../../../core/controllers/auth_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _nameController;
  late TextEditingController _userNameController;
  late TextEditingController _bioController;
  late TextEditingController _websiteController;
  late TextEditingController _emailController;
  late String _selectedBirthYear;
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    final user = AuthController.to.user.value;

    _nameController = TextEditingController(text: user?.name ?? '');
    _userNameController = TextEditingController(text: user?.username ?? '');
    _bioController = TextEditingController(text: user?.bio ?? '');
    _websiteController = TextEditingController(text: user?.website ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _selectedBirthYear = user?.birthYear ?? '2005';
    _selectedGender = user?.gender ?? 'Female';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _bioController.dispose();
    _websiteController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  static const List<String> _genders = [
    'Female',
    'Male',
    'Non-binary',
    'Prefer not to say',
  ];

  static final List<String> _years = List.generate(
    80,(i) => (1944 + i).toString(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios,color:AppColors.textOnDark, size: 20),
        ),
        title: Text('Edit Profile',
          style: AppTextStyles.displaySmall),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.white),
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
                        Obx(() => CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: AuthController.to.user.value?.profileImageUrl != null
                              ? NetworkImage(AuthController.to.user.value!.profileImageUrl!)
                              : null,
                          child: AuthController.to.user.value?.profileImageUrl == null
                              ? Image.asset('assets/icons/person.png')
                              : null,
                        )),
                        const SizedBox(height: 8),
                        Text('Edit Photo',
                            style:AppTextStyles.caption),
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
                  const SizedBox(height: 24),

                  // Get content prompt
                  Align(
                    alignment: Alignment.center,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 10, height: 10,
                        decoration: BoxDecoration(
                          color:AppColors.linkColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                       Text('Get content you`ll really like! Tell us more.',
                        style:AppTextStyles.overline.copyWith(color: Color(0xFFDBDBDB)) ,
                      ),
                    ],
                  ),
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
              width: 335,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  AuthController.to.updateProfile(
                    name: _nameController.text,
                    username: _userNameController.text,
                    email: _emailController.text,
                    bio: _bioController.text,
                    website: _websiteController.text,
                    gender: _selectedGender,
                    birthYear: _selectedBirthYear,
                  );
                  Get.back();},
                style: ElevatedButton.styleFrom(
                  backgroundColor:AppColors.linkColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                child: Text('Save',
                    style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
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
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textOnDark),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        style:AppTextStyles.caption.copyWith(color: Color(0xFFF3F3F3)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:AppTextStyles.display.copyWith(color: AppColors.textOnDark),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          border: Border.all(color: AppColors.textOnDark),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: AppTextStyles.display.copyWith(color: AppColors.textOnDark)),
                  const SizedBox(height: 2),
                  Text(value,
                      style: AppTextStyles.caption.copyWith(color: Color(0xFFF3F3F3))),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color:AppColors.textOnDark, size: 20),
          ],
        ),
      ),
    );
  }

  // ── Birth year picker ────────────────────────
  void _showBirthYearPicker() {
    String tempYear = _selectedBirthYear;
    final controller = FixedExtentScrollController(
      initialItem: _years.indexOf(tempYear).clamp(0, _years.length - 1),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF242424),
        title: Text('Birth Year',
            style: AppTextStyles.displaySmall,
            textAlign: TextAlign.center),
        content: SizedBox(
          height: 250,
          child: ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 60,
            perspective: 0.005,
            onSelectedItemChanged: (i) {
              tempYear = _years[i];
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _years[i],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Divider(color: Colors.white12, height: 10),
                    ),
                  ],
                );
              },
              childCount: _years.length,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: AppTextStyles.caption),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              setState(() => _selectedBirthYear = tempYear);
              Get.back();
            },
            child: Text('Ok', style: AppTextStyles.caption),
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
        backgroundColor: const Color(0xFF242424),
        title:Text('Gender',
            style: AppTextStyles.displaySmall,
            textAlign: TextAlign.center),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: _genders.map((gender) {
                bool isLast = gender == _genders.last;
                return Column(
                  children: [
              GestureDetector(
                onTap: () {
                  setState(() => _selectedGender = gender);
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(gender,
                      style: AppTextStyles.caption),
                ),
              ),
                    if (isLast)
                      const Divider(color: Colors.white12, height: 2, thickness: 1,
                      ),
                  ],
                );
              }).toList(),
          ),
        actions: [
          TextButton(
            onPressed:(){
              Get.back();
              },
            child:Text('Cancel',
                style: AppTextStyles.caption),
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
        backgroundColor: const Color(0xFF242424),
        title: Text('Choose your photo',
            style: AppTextStyles.displaySmall,
            textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                  Get.back();
              },
              child:  Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Take a picture',
                    style:AppTextStyles.caption),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Choose from gallery',
                    style:AppTextStyles.caption)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child:Text('Cancel',
                style:AppTextStyles.caption),
          ),
        ],
      ),
    );
  }

  // ── More options (3-dot) ─────────────────────
  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF282828),
      constraints: const BoxConstraints(
        maxWidth: double.infinity),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF444444),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Image.asset('assets/icons/delete.png', color: AppColors.linkColor, width: 22),
                title: Text('Delete account',
                    style: AppTextStyles.caption.copyWith(color: AppColors.linkColor)),
                onTap: () {
                  Get.back();
                  _showDeleteConfirm();
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  // ── Delete confirm dialog ────────────────────
  void _showDeleteConfirm() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF333333),
        title:Text('Are you sure you want to delete account?',
            style:AppTextStyles.caption,
          textAlign: TextAlign.center),
        content: Text(
          'Deleting your account is permanent and means you won\'t be able to recover all your data, including saved articles, comments and followed medias.',
          style:AppTextStyles.caption,
            textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child:Text('Cancel',
                style:AppTextStyles.headlineMedium),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Delete',
                style: AppTextStyles.headlineMedium.copyWith(color: AppColors.linkColor)),
          ),
        ],
      ),
    );
  }
}