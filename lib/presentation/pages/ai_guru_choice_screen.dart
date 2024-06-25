import 'package:flutter/material.dart';
import 'package:loveguru_ai/business/router/app_router.dart';
import 'package:loveguru_ai/presentation/pages/base/global_margin.dart';
import 'package:loveguru_ai/presentation/providers/guru_provider.dart';
import 'package:loveguru_ai/presentation/widgets/ads.dart';
import 'package:loveguru_ai/presentation/widgets/buttons/custom_solid_button.dart';
import 'package:loveguru_ai/utils/colors.dart';
import 'package:loveguru_ai/utils/textstyles.dart';

class AIGuruChoiceScreen extends StatelessWidget {
  const AIGuruChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GlobalMargin(
            child: Column(
          children: [
            // const GoogleBannerAdSpaceWidget(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "HELLO ",
                      style: TStyle.gilroyBold.body2,
                      children: [
                        TextSpan(
                          text: "${GuruProvider.username.toUpperCase()}!",
                          style: TStyle.gilroyBold.body2.colour(AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "CHOSSE YOUR LOVEGURU",
                    style: TStyle.gilroyLight,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: GuruProvider.gurus.length,
                itemBuilder: (ctx, i) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                image: DecorationImage(image: NetworkImage(GuruProvider.gurus[i].dpUrl), fit: BoxFit.cover)),
                            height: 80,
                            width: 80,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                GuruProvider.gurus[i].name,
                                style: TStyle.gilroyBold.body1,
                              ),
                              Text("Rating: ${GuruProvider.gurus[i].rating}", style: TStyle.gilroyMedium.body4.colour(AppColors.primaryColor)),
                              const SizedBox(height: 10),
                              Text(
                                GuruProvider.gurus[i].desc,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TStyle.gilroyRegular.body3.colour(Colors.grey),
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomSolidButton(
                        child: Text(
                          "TALK TO ${GuruProvider.gurus[i].name.split(' ').first.toUpperCase()}",
                          style: TStyle.gilroySemiBold.body1.colour(Colors.white),
                        ),
                        onPressed: () {
                          AppRouter.router.push('/guru');
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
