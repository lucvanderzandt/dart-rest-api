import 'package:messagebird/src/webhooks/webhooks_service.dart';

import '../general/model/message.dart';
import 'model/conversation.dart';
import 'model/conversation_message.dart';
import 'model/message_response.dart';

/// Conversations service interface.
abstract class ConversationsService {
  /// Enables notifications to be delivered to another server.
  WebhooksService webhooks;

  /// Get the API endpoint.
  String getEndpoint();

  /// Retrieve all conversations for this account. By default,
  /// conversations are sorted by their lastReceivedDatetime field so that
  /// conversations with new messages appear first. No parameters are required;
  /// however, filters and pagination can be provided through the
  /// optional query parameters.
  Future<List<Conversation>> list(
      {int limit, int offset, List<String> ids, ConversationStatus status});

  /// Retrieve all the messages from the conversation with the provided [id].
  Future<List<Message>> listMessages(String id, {int limit, int offset});

  /// Retrieve a single conversation.
  Future<Conversation> read(String id);

  /// View a message.
  Future<Message> readMessage(String id);

  /// Add a new message to an existing conversation and sends it to the
  /// contact that you're in conversation with.
  Future<Message> reply(String id, Message message);

  /// Send a new message to a channel-specific user identifier (e.g. phone
  /// number). If an active conversation already exists for the recipient,
  /// this conversation will be resumed. If an active conversation does not
  /// exist, a new one will be created.
  Future<MessageResponse> send(ConversationMessage message);

  /// Start a new conversation from a channel-specific user identifier,
  /// such as a phone number, and sends a first message. If an active
  /// conversation already exists for the recipient, this conversation will
  /// be resumed.
  Future<Conversation> start(ConversationMessage message);

  /// Set the status of a conversation.
  Future<Conversation> update(String id, ConversationStatus status);
}
