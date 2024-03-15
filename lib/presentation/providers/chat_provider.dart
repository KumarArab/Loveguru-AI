import 'package:loveguru_ai/core/models/chat_model.dart';

class ChatProvider {
  static String aarohiassistantId = "asst_cD6CZBxMjQmXG9a0f2BmrWf2";
  static String? threadId;
  static String? runId;
  static List<ChatModel> chats = [];

  static dispose() {
    threadId = null;
    runId = null;
    chats = [];
  }
}
