class ProfileResponse {
  ProfileResponse({
    required this.statusCode,
    required this.message,
    required this.sucess,
    required this.data,
  });

  final int? statusCode;
  final String? message;
  final bool? sucess;
  final Data? data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      statusCode: json["statusCode"],
      message: json["message"],
      sucess: json["sucess"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "sucess": sucess,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.location,
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.role,
    required this.imageUrl,
    required this.isAvailableForDonation,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final Location? location;
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? bloodGroup;
  final String? role;
  final String? imageUrl;
  final bool? isAvailableForDonation;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      bloodGroup: json["bloodGroup"],
      role: json["role"],
      imageUrl: json["imageUrl"],
      isAvailableForDonation: json["isAvailableForDonation"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "bloodGroup": bloodGroup,
        "role": role,
        "imageUrl": imageUrl,
        "isAvailableForDonation": isAvailableForDonation,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
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

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates.map((x) => x).toList(),
      };
}
