import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loveguru_ai/business/router/app_router.dart';
import 'package:loveguru_ai/presentation/pages/base/global_margin.dart';
import 'package:loveguru_ai/presentation/widgets/buttons/custom_outline_button.dart';
import 'package:loveguru_ai/utils/assets.dart';
import 'package:loveguru_ai/utils/colors.dart';
import 'package:loveguru_ai/utils/extensions/text_beautify.dart';
import 'package:loveguru_ai/utils/textstyles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalMargin(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 220,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Looking", style: TStyle.gilroyBold.title50),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "for ",
                          style: TStyle.gilroyBold.title4.setHeight(2),
                        ),
                        SvgPicture.asset(Assets.love)
                      ],
                    ),
                    Text(
                      "ADVICE?",
                      style: TStyle.gilroyExtraBold.title50,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    "By logging in, you accept our *T&C*. Read *privacy policy*".beautify(
                      alignment: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    CustomOutlineButton(
                        child: "TALK TO *LOVEGURU* AI".beautify(
                          boldStyle: TStyle.gilroySemiBold.body3.colour(AppColors.primaryColor),
                        ),
                        onPressed: () {
                          AppRouter.router.go('/guru');
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
