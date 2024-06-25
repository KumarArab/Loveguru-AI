import 'package:flutter/material.dart';
import 'package:loveguru_ai/business/router/app_router.dart';
import 'package:loveguru_ai/presentation/pages/base/global_margin.dart';
import 'package:loveguru_ai/presentation/providers/guru_provider.dart';
import 'package:loveguru_ai/presentation/widgets/ads.dart';
import 'package:loveguru_ai/presentation/widgets/buttons/custom_solid_button.dart';
import 'package:loveguru_ai/utils/colors.dart';
import 'package:loveguru_ai/utils/textstyles.dart';

class GuruDetailsScreen extends StatelessWidget {
  const GuruDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GlobalMargin(
        child: Column(
          children: [
          //  const  GoogleBannerAdSpaceWidget(),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                  Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(image: AssetImage(GuruProvider.gurus[0].dpUrl), fit: BoxFit.cover),),
                  height: 100,
                  width: 100,
                ), 
               const SizedBox(height: 32),
               Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      GuruProvider.gurus[0].name,
                      style: TStyle.gilroyBold.title3,
                    ),
                    Text("Rating: ${GuruProvider.gurus[0].rating}",
                        style: TStyle.gilroyMedium.body3.colour(AppColors.primaryColor)),
                    const SizedBox(height: 10),
                    Text(
                      GuruProvider.gurus[0].desc,
               
                     textAlign: TextAlign.center,
                      style: TStyle.gilroyRegular.body3.colour(Colors.grey),
                    ),
                  ],
                )

              ],
            )),
            Text("Disclaimer: This is an Artificial Intelligence you are talking to not a Human. Please be careful of your language. We do not take any responsibility for your actions.",
            textAlign: TextAlign.center,
            style: TStyle.gilroyMedium.body4.colour(AppColors.primaryColor),)
            ,const SizedBox(height: 16),
            CustomSolidButton(
              child: Text(
                "START CHATTING",
                style: TStyle.gilroySemiBold.body1.colour(Colors.white),
              ),
              onPressed: () {
                AppRouter.router.pushReplacement("/chat");
              },
            )
          ],
        ),
      )),
    );
  }
}
