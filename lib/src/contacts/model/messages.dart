/// Class encapsulating a [Messages] object.
class Messages {
  /// The total count of messages sent to contact.
  int totalCount;

  /// URL which can be used to retrieve list of messages sent to contact.
  String href;

  /// Constructor.
  Messages({this.totalCount, this.href});

  /// Construct a [Messages] object from a [json] object.
  factory Messages.fromJson(Map<String, dynamic> json) => (json == null)
      ? null
      : Messages(
          totalCount: int.parse(json['totalCount']),
          href: json['href'].toString());

  /// Get a json object representing the [Messages]
  Map<String, dynamic> toJson() => {'totalCount': totalCount, 'href': href};
}