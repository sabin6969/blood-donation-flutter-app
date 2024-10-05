class NearByDonorResponse {
  NearByDonorResponse({
    required this.statusCode,
    required this.message,
    required this.sucess,
    required this.data,
  });

  final int? statusCode;
  final String? message;
  final bool? sucess;
  final List<Datum> data;

  factory NearByDonorResponse.fromJson(Map<String, dynamic> json) {
    return NearByDonorResponse(
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
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.location,
    required this.role,
    required this.imageUrl,
    required this.isAvailableForDonation,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.distanceFromYou,
  });

  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? bloodGroup;
  final Location? location;
  final String? role;
  final String? imageUrl;
  final bool? isAvailableForDonation;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final double? distanceFromYou;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      bloodGroup: json["bloodGroup"],
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      role: json["role"],
      imageUrl: json["imageUrl"],
      isAvailableForDonation: json["isAvailableForDonation"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      distanceFromYou: json["distanceFromYou"],
    );
  }
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json["type"],
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(json["coordinates"]!.map((x) => x)),
    );
  }
}
