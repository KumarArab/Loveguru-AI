class ApiPath {
  static const chatCompletion = "chat/completions";
  static const assistant = "assistants";
  static const threads = "threads";
  static addMessageToThreads(String threadId) => "threads/$threadId/messages";
  static listMessages(String threadId) => "threads/$threadId/messages";
  static createRun(String threadId) => "threads/$threadId/runs";
  static runStatus(String threadId, String runId) => "threads/$threadId/runs/$runId";
}
