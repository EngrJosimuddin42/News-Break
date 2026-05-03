import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/me/me_controller.dart';

class MeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            icon: Image.asset('assets/icons/add.png', width: 22, height: 22),
            onPressed: () => Get.find<MeController>().onAI()),
        IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white,size: 20),
            onPressed: () => Get.find<MeController>().onSettings()),
      ],
    );
  }
}
