class CampaignResponse {
  CampaignResponse({
    required this.statusCode,
    required this.message,
    required this.sucess,
    required this.data,
  });

  final int? statusCode;
  final String? message;
  final bool? sucess;
  final List<Datum> data;

  factory CampaignResponse.fromJson(Map<String, dynamic> json) {
    return CampaignResponse(
      statusCode: json["statusCode"],
      message: json["message"],
      sucess: json["sucess"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.campaignName,
    required this.timeStamp,
    required this.isActive,
    required this.organizedBy,
    required this.location,
    required this.participants,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.organizer,
    required this.isAlreadyParticipated,
  });

  final String? id;
  final String? campaignName;
  final DateTime? timeStamp;
  final bool? isActive;
  final String? organizedBy;
  final Location? location;
  final List<dynamic> participants;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final Organizer? organizer;
  final bool? isAlreadyParticipated;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"],
      campaignName: json["campaignName"],
      timeStamp: DateTime.tryParse(json["timeStamp"] ?? ""),
      isActive: json["isActive"],
      organizedBy: json["organizedBy"],
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      participants: json["participants"] == null
          ? []
          : List<dynamic>.from(json["participants"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      organizer: json["organizer"] == null
          ? null
          : Organizer.fromJson(json["organizer"]),
      isAlreadyParticipated: json["isAlreadyParticipated"],
    );
  }
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<num> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json["type"],
      coordinates: json["coordinates"] == null
          ? []
          : List<num>.from(json["coordinates"]!.map((x) => x)),
    );
  }
}

class Organizer {
  Organizer({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
  });

  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? imageUrl;

  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      imageUrl: json["imageUrl"],
    );
  }
}
