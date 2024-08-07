import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sco_v1/utils/utils.dart';
import 'package:sco_v1/viewModel/language_change_ViewModel.dart';

import '../app_colors.dart';
import '../app_text_styles.dart';

class CustomSimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  const CustomSimpleAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageChangeViewModel>(context);
    return Directionality(
      textDirection: getTextDirection(provider),
      child: AppBar(
        backgroundColor: Colors.white,
        title: title,

        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.scoButtonColor,
          ),
          onPressed: () {
           Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
