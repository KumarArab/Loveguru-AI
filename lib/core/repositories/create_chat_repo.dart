import 'dart:developer';

import 'package:loveguru_ai/core/api_path.dart';
import 'package:loveguru_ai/core/api_service.dart';
import 'package:loveguru_ai/core/models/chat_model.dart';
import 'package:loveguru_ai/core/models/guru_model.dart';
import 'package:loveguru_ai/core/models/timestamp_model.dart';
import 'package:loveguru_ai/presentation/providers/chat_provider.dart';
import 'package:loveguru_ai/presentation/providers/guru_provider.dart';

enum RunStatus { queued, in_progress, completed, failed, cancelled, cancelling, expired, unknown }

class CreateChatRepo {
  Future<void> initialSetup() async {
    setAssistant();
    await createThreadAndAddInitialMessage();
    await listMessagesOfTheThread(null);
    await createARun();
  }

  GuruProfileModel setAssistant() {
    return GuruProvider.selectedGuru = GuruProvider.gurus[0];
  }

  Future<bool> createThreadAndAddInitialMessage() async {
    final res = await createThread("Hey! I'm ${GuruProvider.username}");
    return res;
  }

  Future<bool> createThread(String message) async {
    final head = {
      "OpenAI-Beta": "assistants=v1",
    };

    final body = {
      "messages": [
        {"role": "user", "content": message}
      ]
    };

    try {
      final res = await ApiService.postData(
        ApiPath.threads,
        head: head,
        body: body,
      );
      ChatProvider.threadId = res["id"];
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> addMessageToThread(String message) async {
    if (ChatProvider.threadId == null) {
      return false;
    }
    final head = {
      "OpenAI-Beta": "assistants=v1",
    };
    try {
      await ApiService.postData(
        ApiPath.addMessageToThreads(ChatProvider.threadId!),
        body: {
          "role": "user",
          "content": message,
        },
        head: head,
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> listMessagesOfTheThread([String? latestMessageId]) async {
    try {
      final Map<String, dynamic> queryParam = {};
      List<ChatModel> chats = [];
      if (ChatProvider.threadId == null) return false;
      // if (latestMessageId != null) {
      //   queryParam["after"] = latestMessageId;
      // }

      final head = {
        "OpenAI-Beta": "assistants=v1",
      };
      final res = await ApiService.getData(
        ApiPath.listMessages(ChatProvider.threadId!),
        queryParams: queryParam,
        head: head,
      );

      res["data"].forEach((item) => chats.add(
            ChatModel(
                id: item['id'],
                timestamp: TimestampModel.fromSeconds(item["created_at"]),
                owner: item["role"] == "assistant" ? ChatOwner.ai : ChatOwner.user,
                message: item["content"][0]["text"]["value"]),
          ));
      for (var chat in chats) {
        if (ChatProvider.chats.indexWhere((ChatModel c) => c.id == chat.id) == -1) {
          ChatProvider.chats.add(chat);
        }
      }
      ChatProvider.chats.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> createARun([String? instructions]) async {
    try {
      if (ChatProvider.threadId == null) return false;
      final head = {
        "OpenAI-Beta": "assistants=v1",
      };
      final Map<String, dynamic> body = {"assistant_id": ChatProvider.aarohiassistantId};

      if (instructions != null) {
        body["instructions"] = instructions;
      }

      final res = await ApiService.postData(ApiPath.createRun(ChatProvider.threadId!), body: body, head: head);
      ChatProvider.runId = res["id"];
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<RunStatus> getRunStatus() async {
    if (ChatProvider.threadId == null || ChatProvider.runId == null) return RunStatus.unknown;
    final head = {
      "OpenAI-Beta": "assistants=v1",
    };
    try {
      final res = await ApiService.getData(ApiPath.runStatus(ChatProvider.threadId!, ChatProvider.runId!), head: head);

      final RunStatus status = RunStatus.values
          .firstWhere((element) => element.name.toString() == res["status"], orElse: () => RunStatus.unknown);

      if (status == RunStatus.in_progress || status == RunStatus.queued) {
        await Future.delayed(const Duration(seconds: 2), () async {
          return await getRunStatus();
        });
      } else if (status == RunStatus.completed) {
        if (ChatProvider.chats.isNotEmpty) {
          await listMessagesOfTheThread(ChatProvider.chats.last.id);
        } else {
          await listMessagesOfTheThread();
        }
      }
      return status;
    } catch (e) {
      log(e.toString());
      return RunStatus.unknown;
    }
  }
}
