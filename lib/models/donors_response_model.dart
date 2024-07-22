class DonorsResponse {
  DonorsResponse({
    required this.statusCode,
    required this.message,
    required this.sucess,
    required this.data,
  });

  final int? statusCode;
  final String? message;
  final bool? sucess;
  final List<Datum> data;

  factory DonorsResponse.fromJson(Map<String, dynamic> json) {
    return DonorsResponse(
      statusCode: json["statusCode"],
      message: json["message"],
      sucess: json["sucess"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "sucess": sucess,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Datum {
  Datum({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.location,
    required this.imageUrl,
    required this.isAvailableForDonation,
    required this.v,
  });

  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? bloodGroup;
  final Location? location;
  final String? imageUrl;
  final bool? isAvailableForDonation;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      bloodGroup: json["bloodGroup"],
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      imageUrl: json["imageUrl"],
      isAvailableForDonation: json["isAvailableForDonation"],
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "bloodGroup": bloodGroup,
        "location": location?.toJson(),
        "imageUrl": imageUrl,
        "isAvailableForDonation": isAvailableForDonation,
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
