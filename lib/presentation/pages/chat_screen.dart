import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:loveguru_ai/business/router/app_router.dart';
import 'package:loveguru_ai/core/api_path.dart';
import 'package:loveguru_ai/core/api_service.dart';
import 'package:loveguru_ai/core/models/chat_model.dart';
import 'package:loveguru_ai/core/models/timestamp_model.dart';
import 'package:loveguru_ai/core/repositories/create_chat_repo.dart';
import 'package:loveguru_ai/presentation/pages/base/global_margin.dart';
import 'package:loveguru_ai/presentation/providers/chat_provider.dart';
import 'package:loveguru_ai/presentation/providers/guru_provider.dart';
import 'package:loveguru_ai/presentation/widgets/ads.dart';
import 'package:loveguru_ai/utils/assets.dart';
import 'package:loveguru_ai/utils/colors.dart';
import 'package:loveguru_ai/utils/textstyles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool _showTyping = false;

  CreateChatRepo chatRepo = CreateChatRepo();

  bool get showTyping => _showTyping;
  set showTyping(bool val) {
    if (mounted) {
      setState(() {
        _showTyping = val;
      });
    }
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    if (mounted) {
      setState(() {
        _isLoading = val;
      });
    }
  }

  @override
  void initState() {
    //   chatRepo.initialSetup().then((val) {
    //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //       showTyping = true;

    //       // await chatRepo.getRunStatus();
    //       showTyping = false;
    //       isLoading = false;
    //     });
    //   });

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    ChatProvider.dispose();
    GuruProvider.dispose();
    super.dispose();
  }

  makePostRequest(BuildContext context) async {
    // setState(() {
    //   showTyping = true;
    // });

    // try {
    //   await chatRepo.addMessageToThread(textEditingController.text);
    //   await chatRepo.createARun();
    //   await chatRepo.getRunStatus();
    //   await Future.delayed(Duration(seconds: 2), () async {
    //     await chatRepo.getRunStatus();
    //   });
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     backgroundColor: Colors.black,
    //     content: Text(
    //       "Something went wrong!!, please try again.",
    //       style: TStyle.gilroyMedium.body3.colour(Colors.white),
    //     ),
    //   ));
    // }
    // setState(() {
    //   showTyping = false;
    // });
    ChatProvider.chats
        .add(ChatModel(id: "dfdsf", timestamp: TimestampModel.currentTimeStamp(), owner: ChatOwner.user, message: textEditingController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GlobalMargin(
          child: Column(
            children: [
              // const GoogleBannerAdSpaceWidget(),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(GuruProvider.gurus[0].dpUrl),
                      radius: 20,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          GuruProvider.gurus[0].name,
                          style: TStyle.gilroySemiBold.body0,
                        ),
                        Text(
                          "Offline",
                          style: TStyle.gilroyBold.body4.colour(AppColors.primaryColor),
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app, color: AppColors.primaryColor),
                      onPressed: () {
                        AppRouter.router.go('/');
                      },
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.black12,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: ChatProvider.chats.length,
                    reverse: true,
                    itemBuilder: (ctx, i) {
                      int chatIndex = ChatProvider.chats.length - 1 - i;
                      bool isAI = ChatProvider.chats[chatIndex].owner == ChatOwner.ai;
                      return Align(
                        alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(vertical: 1),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(8),
                                    topRight: const Radius.circular(8),
                                    bottomLeft: Radius.circular(isAI ? 0 : 8),
                                    bottomRight: Radius.circular(isAI ? 8 : 0)),
                                color: isAI ? const Color(0xffF7F7F7) : Colors.black),
                            child: Text(
                              ChatProvider.chats[chatIndex].message,
                              style: TStyle.gilroyRegular.body2.colour(isAI ? Colors.black : Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(8)),
                          color: Color(0xffF7F7F7)),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      height: showTyping ? 30 : 0,
                      width: 50,
                      margin: const EdgeInsets.only(top: 12),
                      child: Lottie.asset(Assets.typing, fit: BoxFit.contain))),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffF8F8F8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        controller: textEditingController,
                        style: TStyle.gilroyRegular.body3,
                        maxLines: 1,
                        enabled: !showTyping,
                        decoration: InputDecoration(
                            hintText: "Write a message",
                            hintStyle: TStyle.gilroyLight.body3.colour(Colors.grey),
                            fillColor: Colors.black,
                            border: InputBorder.none),
                        onFieldSubmitted: (val) {
                          if (textEditingController.text.isNotEmpty) {
                            setState(() {
                              makePostRequest(context);
                              textEditingController.text = "";
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        // minimumSize: const Size.fromHeight(40),
                        // maximumSize: const Size.fromWidth(double.maxFinite),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (textEditingController.text.isNotEmpty) {
                          setState(() {
                            makePostRequest(context);
                            textEditingController.text = "";
                          });
                        }
                      },
                      label: Text(
                        "",
                        style: TStyle.gilroyMedium.body2.colour(Colors.white),
                      ),
                      icon: Transform.translate(
                        offset: const Offset(8, -3),
                        child: Transform.rotate(
                          angle: math.pi / -4,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
