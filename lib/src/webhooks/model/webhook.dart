import 'dart:convert';

/// Class encapsulating a [Webhook] object.
class Webhook {
  /// The unique ID generated by the MessageBird platform that identifies this
  /// webhook.
  final String id;

  /// A list of event name strings from the list of available events that
  /// trigger this webhook.
  final List<String> events;

  /// The unique identifier for a MessageBird channel that this webhook will
  /// subcribe to events for.
  final String channelId;

  /// The endpoint URL on your server that requests are sent to.
  final String url;

  /// The status of the webhook. See [WebhookStatus] for allowed values.
  final WebhookStatus status;

  /// Constructor.
  Webhook({this.id, this.events, this.channelId, this.url, this.status});

  /// Construct a [Webhook] object from a json [String].
  factory Webhook.fromJson(String source) =>
      Webhook.fromMap(json.decode(source)['data'][0] ?? json.decode(source));

  /// Construct a [Webhook] object from a [Map].
  factory Webhook.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Webhook(
          id: map['id'],
          events: List<String>.from(map['events']),
          channelId: map['channelId'],
          url: map['url'],
          status: WebhookStatus.values.firstWhere((status) =>
              status.toString() ==
              'WebhookStatus.${map['status']}'.replaceAll(' ', '_')));

  /// Get a json [String] representing the [Webhook].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'events': List<dynamic>.from(events.map((x) => x)),
        'channelId': channelId,
        'url': url,
        'status': status?.toString()?.replaceAll('WebhookStatus.', ''),
      };

  /// Get a list of [Webhook] objects from a json [String].
  static List<Webhook> fromJsonList(String source) => source == null
      ? null
      : json.decode(source)['totalCount'] == 0 ??
              json.decode(source)['pagination']['totalCount'] == 0
          ? <Webhook>[]
          : List.from(json.decode(source)['data'] ?? json.decode(source))
              .map((j) => Webhook.fromJson(j))
              .toList();
}

/// Enumeration of [Webhook] statusses.
enum WebhookStatus {
  /// [Webhook] is enabled.
  enabled,

  /// [Webhook] is disabled.
  disabled
}