import 'content.dart';

/// Class encapsulating a [Message] object.
///
/// Messages that have been sent by, or received from, a customer are
/// automatically threaded in a conversation. Any messages sent through the API
/// or received from your customer across any of your configured channels can be
/// retrieved via the messages endpoint. Messages are returned from the API in
/// the order they were created, with newest messages returned first. Certain
/// message types are channel specific such as a Highly Structured Message
/// (HSM), which are pre-approved message templates used by WhatsApp.
class Message {
  String id;
  String conversationId;
  String channelId;
  String to;
  String from;
  MessageDirection direction;
  MessageStatus status;
  MessageType type;
  Content content;
  DateTime createdDatetime;
  DateTime updatedDatetime;
  Map<String, dynamic> source;

  /// Constructor.
  Message(
      {this.id,
      this.conversationId,
      this.channelId,
      this.to,
      this.from,
      this.direction,
      this.status,
      this.type,
      this.content,
      this.createdDatetime,
      this.updatedDatetime,
      this.source});

  /// Construct a [Message] object from a [json] object.
  factory Message.fromJson(Map<String, dynamic> json) {
    final MessageType type = MessageType.values.firstWhere(
        (type) => type.toString() == 'MessageType.${json['type'].toString()}',
        orElse: () => null);
    return json == null
        ? null
        : Message(
            id: json['id'].toString(),
            conversationId: json['conversationId'].toString(),
            channelId: json['channelId'].toString(),
            to: json['to'].toString(),
            from: json['from'].toString(),
            direction: MessageDirection.values.firstWhere(
                (direction) =>
                    direction.toString() ==
                    'MessageDirection.${json['direction'].toString()}',
                orElse: () => null),
            status: MessageStatus.values.firstWhere(
                (status) =>
                    status.toString() ==
                    'MessageStatus.${json['status'].toString()}',
                orElse: () => null),
            type: type,
            content: Content.get(type, json['content']),
            createdDatetime: DateTime.parse(json['createdDatetime'].toString()),
            updatedDatetime: DateTime.parse(json['updatedDatetime'].toString()),
            source: json['source']);
  }

  /// Get a list of [Message] objects from a [json] object
  static List<Message> fromJsonList(Object json) => json == null
      ? null
      : List.from(json).map((j) => Message.fromJson(j)).toList();

  /// Get a json object representing the [Message]
  Map<String, dynamic> toJson() => {
        'to': to,
        'from': from,
        'direction': direction.toString().replaceAll('MessageDirection.', ''),
        'type': type.toString().replaceAll('MessageType.', ''),
        'content': content,
        'source': source
      };
}

/// The direction of the message.
enum MessageDirection {
  /// Outbound message sent through the API.
  sent,

  /// Inbound message received from a customer.
  received
}

/// The type of message content.
enum MessageType {
  /// Text message type.
  text,

  /// Image message type.
  image,

  /// Audio content type.
  audio,

  /// Video content type.
  video,

  /// Location content type.
  location,

  /// File content type.
  file,

  /// Highly Structured Message (HSM) content type. Only available for WhatsApp.
  hsm,

  /// Email content type.
  email
}

/// The status of the message.
enum MessageStatus {
  /// Message pending.
  pending,

  /// Message received.
  received,

  /// Message sent.
  sent,

  /// Message delivered.
  delivered,

  /// Message read.
  read,

  /// Message unsupported.
  unsupported,

  /// Message delivery failed.
  failed,

  /// Message deleted.
  deleted
}
