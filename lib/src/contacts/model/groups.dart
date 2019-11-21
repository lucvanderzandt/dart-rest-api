/// Class encapsulating a [Groups] object.
class Groups {
  /// The total count of groups that contact belongs to.
  int totalCount;

  /// URL which can be used to retrieve list of groups contact belongs to.
  String href;

  /// Constructor.
  Groups({this.totalCount, this.href});

  /// Construct a [Groups] object from a [json] object.
  factory Groups.fromJson(Map<String, dynamic> json) => (json == null)
      ? null
      : Groups(
          totalCount: int.parse(json['totalCount']),
          href: json['href'].toString());

  /// Get a json object representing the [Groups]
  Map<String, dynamic> toJson() => {'totalCount': totalCount, 'href': href};
}