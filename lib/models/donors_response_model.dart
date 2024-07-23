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
  final Data? data;

  factory DonorsResponse.fromJson(Map<String, dynamic> json) {
    return DonorsResponse(
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
    required this.docs,
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });

  final List<Doc> docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPages;
  final int? page;
  final int? pagingCounter;
  final bool? hasPrevPage;
  final bool? hasNextPage;
  final dynamic prevPage;
  final dynamic nextPage;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      docs: json["docs"] == null
          ? []
          : List<Doc>.from(json["docs"]!.map((x) => Doc.fromJson(x))),
      totalDocs: json["totalDocs"],
      limit: json["limit"],
      totalPages: json["totalPages"],
      page: json["page"],
      pagingCounter: json["pagingCounter"],
      hasPrevPage: json["hasPrevPage"],
      hasNextPage: json["hasNextPage"],
      prevPage: json["prevPage"],
      nextPage: json["nextPage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "docs": docs.map((x) => x.toJson()).toList(),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class Doc {
  Doc({
    required this.location,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.imageUrl,
    required this.isAvailableForDonation,
    required this.v,
  });

  final Location? location;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? bloodGroup;
  final String? imageUrl;
  final bool? isAvailableForDonation;
  final int? v;

  factory Doc.fromJson(Map<String, dynamic> json) {
    return Doc(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      bloodGroup: json["bloodGroup"],
      imageUrl: json["imageUrl"],
      isAvailableForDonation: json["isAvailableForDonation"],
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "bloodGroup": bloodGroup,
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
