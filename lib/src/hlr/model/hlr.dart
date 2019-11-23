import 'dart:convert';

/// Class encapsulating an [Hlr] (Home Location Registering) object.
class Hlr {
  /// A unique random ID which is created on the MessageBird platform and is
  /// returned upon creation of the object.
  String id;

  /// The URL of the created object.
  String href;

  /// The telephone number.
  int msisdn;

  /// The [MCCMNC](https://en.wikipedia.org/wiki/Mobile_country_code) code of
  /// the network provider.
  int network;

  /// A client reference.
  String reference;

  /// Extra HLR information. See [HlrDetails] for extra information.
  HlrDetails details;

  /// The status of the msisdns. See [HlrStatus] for allowed values.
  HlrStatus status;

  /// The date and time of the creation of the message in RFC3339 format
  /// (Y-m-d\TH:i:sP)
  DateTime createdDatetime;

  /// The datum time of the last status in RFC3339 format (Y-m-d\TH:i:sP)
  DateTime statusDatetime;

  /// Constructor.
  Hlr({
    this.id,
    this.href,
    this.msisdn,
    this.network,
    this.reference,
    this.details,
    this.status,
    this.createdDatetime,
    this.statusDatetime,
  });

  /// Construct an [Hlr] object from a json [String].
  factory Hlr.fromJson(String source) {
    final decoded = json.decode(source)['data'];
    if (decoded is List<dynamic> && decoded.length != 1) {
      throw Exception('Tried to decode a single object from a list of '
          'multiple objects. Use function "fromJsonList" instead');
    }
    return Hlr.fromMap(decoded == null ? json.decode(source) : decoded[0]);
  }

  /// Construct an [Hlr] object from a [Map].
  factory Hlr.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Hlr(
          id: map['id'],
          href: map['href'],
          msisdn: map['msisdn'],
          network: map['network'],
          reference: map['reference'],
          details: map['details'],
          status: HlrStatus.values.firstWhere(
              (status) => status.toString() == 'HlrStatus.${map['status']}',
              orElse: () => HlrStatus.unknown),
          createdDatetime:
              DateTime.fromMillisecondsSinceEpoch(map['createdDatetime']),
          statusDatetime:
              DateTime.fromMillisecondsSinceEpoch(map['statusDatetime']),
        );

  /// Get a json [String] representing the [Hlr].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'href': href,
        'msisdn': msisdn,
        'network': network,
        'reference': reference,
        'details': details.toMap(),
        'status': status.toString().replaceAll('HlrStatus.', ''),
        'createdDatetime': createdDatetime.toIso8601String(),
        'statusDatetime': statusDatetime.toIso8601String(),
      };
}

/// Class encapsulating [HlrDetails].
///
/// Note that the attributes can change over time and some of them can be null
/// because not all information is available for all countries and provider.
class HlrDetails {
  /// Extended status information
  String status_desc;

  /// [IMSI (International Mobile Subscriber Identity)](https://en.wikipedia.org/wiki/International_mobile_subscriber_identity)
  /// of mobile number.
  String ismi;

  /// Country ISO code of location of MSISDN.
  String country_iso;

  /// Country name of location of MSISDN.
  String country_name;

  /// [MSC (Mobile Switching Center)](https://en.wikipedia.org/wiki/Network_switching_subsystem#Mobile_switching_center_.28MSC.29)
  /// of MSISDN
  String location_msc;

  /// Country ISO of MSC ([lowercase ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2))
  String location_iso;

  /// Is 1 if the phone number is ported or 0 when the phone number is not
  /// ported or ported status is unknown
  bool ported;

  /// Is 1 if the phone number is roaming or 0 when the phone number is not
  /// roaming or roaming status is unknown
  bool roaming;

  /// Constructor.
  HlrDetails({
    this.status_desc,
    this.ismi,
    this.country_iso,
    this.country_name,
    this.location_msc,
    this.location_iso,
    this.ported,
    this.roaming,
  });

  /// Construct an [HlrDetails] object from a json [String].
  factory HlrDetails.fromJson(String source) =>
      HlrDetails.fromMap(json.decode(source)['data'] ?? json.decode(source));

  /// Construct an [HlrDetails] object from a [Map].
  factory HlrDetails.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : HlrDetails(
          status_desc: map['status_desc'],
          ismi: map['ismi'],
          country_iso: map['country_iso'],
          country_name: map['country_name'],
          location_msc: map['location_msc'],
          location_iso: map['location_iso'],
          ported: map['ported'] == null ? null : int.parse(map['ported']) == 1,
          roaming:
              map['roaming'] == null ? null : int.parse(map['roaming']) == 1,
        );

  /// Get a json [String] representing the [HlrDetails]
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'status_desc': status_desc,
        'ismi': ismi,
        'country_iso': country_iso,
        'country_name': country_name,
        'location_msc': location_msc,
        'location_iso': location_iso,
        'ported': ported,
        'roaming': roaming,
      };
}

/// Enumeration of [Hlr] statusses
enum HlrStatus {
  /// [Hlr] is sent.
  sent,

  /// [Hlr] is absent.
  absent,

  /// [Hlr] is active.
  active,

  /// [Hlr] is unknown.
  unknown,

  /// [Hlr] has failed
  failed
}