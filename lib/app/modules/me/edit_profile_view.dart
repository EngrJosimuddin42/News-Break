import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:news_break/app/theme/app_colors.dart';
import 'package:news_break/app/theme/app_text_styles.dart';
import '../../controllers/auth/auth_controller.dart';
import 'package:image_picker/image_picker.dart' as img_picker;

import '../../controllers/me/edit_profile_controller.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios,color:AppColors.textOnDark, size: 20)),
        title: Text('Edit Profile',
          style: AppTextStyles.displaySmall),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () => _showMoreOptions(context, controller)),
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator(color: AppColors.linkColor))
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Avatar
                  GestureDetector(
                    onTap: () => _showPhotoOptions(context, controller),
                    child: Column(
                      children: [
                        Obx(() {
                        final String? profileUrl = AuthController.to.user.value?.profileImageUrl;
                        return CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: profileUrl != null && profileUrl.isNotEmpty
                              ? (profileUrl.startsWith('http') || profileUrl.startsWith('https')
                              ? NetworkImage(profileUrl) as ImageProvider
                              : FileImage(File(profileUrl)))
                              : null,
                          child: (profileUrl == null || profileUrl.isEmpty)
                              ? Image.asset('assets/icons/person.png')
                              : null,
                        );
                        }),
                        const SizedBox(height: 8),
                        Text('Edit Photo', style: AppTextStyles.caption),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Name
                  _inputField('Name', controller.nameController),
                  const SizedBox(height: 12),

              Row(
                children: [
                  // User Name
                 Expanded(child: _inputField('User Name', controller.userNameController)),
                  const SizedBox(width: 20),
                  // Email
                 Expanded(child: _inputField('Email', controller.emailController,
                      keyboardType: TextInputType.emailAddress)),
                    ]
                  ),

                  const SizedBox(height: 20),
                  // Bio
                  _inputField('Bio', controller.bioController),
                  const SizedBox(height: 20),

                   // Website
                  _inputField('Website', controller.websiteController),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Obx(() => _dropdownField(
                          label: 'Birth year',
                          value: DateFormat('dd/MM/yyyy').format(controller.selectedBirthDate.value),
                          onTap: () => controller.chooseBirthDate(context),
                          isDate: true)),

                  const SizedBox(width: 20),

                  // Gender
                      Obx(() =>_dropdownField(
                      label: 'Gender',
                      value: controller.selectedGender.value,
                    onTap: () => _showGenderPicker(context, controller))),
                  ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Save button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: SizedBox( width: 335, height: 48,
              child: ElevatedButton(
                  onPressed: () => controller.saveProfile(),
                style: ElevatedButton.styleFrom(
                  backgroundColor:AppColors.linkColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                child: Text('Save', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600))))),
        ],
      ),
    ),
    );
  }

  // Input field
  Widget _inputField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelSmall.copyWith(color: Color(0xFF626262))),
        const SizedBox(height: 12),
        Container( height: 52,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.textOnDark),
            borderRadius: BorderRadius.circular(6)),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppTextStyles.bodyMedium,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16)))),
      ],
    );
  }

  //  Dropdown field
  Widget _dropdownField({
    required String label,
    required String value,
    required VoidCallback onTap,
    bool isDate = false,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.labelSmall.copyWith(color: Colors.grey)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onTap,
            child: Container(height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textOnDark),
                borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value, style: AppTextStyles.bodyMedium),
                  Icon( isDate ? Icons.calendar_month_outlined : Icons.keyboard_arrow_down,
                      color: AppColors.info,
                      size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Gender picker
  void _showGenderPicker(BuildContext context, EditProfileController controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF242424),
        title: Text('Gender', style: AppTextStyles.displaySmall, textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: controller.genders.map((gender) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.updateGender(gender);
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(gender, style: AppTextStyles.caption),
                  ),
                ),
                if (gender != controller.genders.last)
                  const Divider(color: Colors.white12, height: 1),
              ],
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: AppTextStyles.caption),
          ),
        ],
      ),
    );
  }

  // Photo options
  void _showPhotoOptions(BuildContext context, EditProfileController controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF242424),
        title: Text('Choose your photo', style: AppTextStyles.displaySmall, textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                  Get.back();
                  AuthController.to.pickAndUploadImage(img_picker.ImageSource.camera);
              },
              child:  Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Take a picture', style:AppTextStyles.caption))),
            GestureDetector(
              onTap: () {
                Get.back();
                AuthController.to.pickAndUploadImage(img_picker.ImageSource.gallery);              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Choose from gallery',
                    style:AppTextStyles.caption))),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child:Text('Cancel', style:AppTextStyles.caption)),
        ],
      ),
    );
  }

  //  More options (3-dot)
  void _showMoreOptions(BuildContext context, EditProfileController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF282828),
      constraints: const BoxConstraints(
        maxWidth: double.infinity),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container( width: 36, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF444444),
                borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Image.asset('assets/icons/delete.png', color: AppColors.linkColor, width: 22),
                title: Text('Delete account', style: AppTextStyles.caption.copyWith(color: AppColors.linkColor)),
                onTap: () {
                  Get.back();
                  _showDeleteConfirm(context);
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  //Delete confirm dialog
  void _showDeleteConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF333333),
        title:Text('Are you sure you want to delete account?', style:AppTextStyles.caption, textAlign: TextAlign.center),
        content: Text( 'Deleting your account is permanent and means you won\'t be able to recover all your data, including saved articles, comments and followed medias.',
          style:AppTextStyles.caption, textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child:Text('Cancel', style:AppTextStyles.headlineMedium)),
          TextButton(
            onPressed: () {
              Get.back();
              AuthController.to.deleteAccount();
            },
            child: Text('Delete', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.linkColor))),
        ],
      ),
    );
  }
}