import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loveguru_ai/business/router/app_router.dart';
import 'package:loveguru_ai/core/models/chat_model.dart';
import 'package:loveguru_ai/core/models/timestamp_model.dart';
import 'package:loveguru_ai/presentation/pages/base/global_margin.dart';
import 'package:loveguru_ai/presentation/providers/chat_provider.dart';
import 'package:loveguru_ai/presentation/providers/guru_provider.dart';
import 'package:loveguru_ai/presentation/widgets/ads.dart';
import 'package:loveguru_ai/presentation/widgets/buttons/custom_solid_button.dart';
import 'package:loveguru_ai/utils/assets.dart';
import 'package:loveguru_ai/utils/textstyles.dart';

class NameScreen extends StatefulWidget {
  NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void saveNameAndProceed(BuildContext context) {
    if (textEditingController.text.isNotEmpty) {
      GuruProvider.username = textEditingController.text;
      AppRouter.router.go("/choice");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          "Please enter your name to continue",
          style: TStyle.gilroyMedium.body3.colour(Colors.white),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GlobalMargin(
        child: Column(
          children: [
            const GoogleBannerAdSpaceWidget(),
            Expanded(
                child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(Assets.logo),
                  const SizedBox(height: 10),
                  Text(
                    "What's your first name?",
                    style: TStyle.gilroySemiBold.title4,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    style: TStyle.gilroyMedium.body2,
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintText: 'Enter your name here',
                        hintStyle: TStyle.gilroyRegular.body2),
                    onSubmitted: (val) => saveNameAndProceed(context),
                  ),
                  const SizedBox(height: 8),
                  Text("You cannot change this once set", style: TStyle.gilroySemiBold.body4)
                ],
              ),
            )),
            CustomSolidButton(
              child: Text(
                "SUBMIT",
                style: TStyle.gilroySemiBold.body1.colour(Colors.white),
              ),
              onPressed: () => saveNameAndProceed(context),
            )
          ],
        ),
      )),
    );
  }
}
