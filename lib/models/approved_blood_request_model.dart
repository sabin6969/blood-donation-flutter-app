class ApprovedBloodRequestModel {
    ApprovedBloodRequestModel({
        required this.statusCode,
        required this.message,
        required this.sucess,
        required this.data,
    });

    final int? statusCode;
    final String? message;
    final bool? sucess;
    final List<Datum> data;

    factory ApprovedBloodRequestModel.fromJson(Map<String, dynamic> json){ 
        return ApprovedBloodRequestModel(
            statusCode: json["statusCode"],
            message: json["message"],
            sucess: json["sucess"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.requestedBy,
        required this.isApproved,
        required this.isReviewed,
        required this.note,
        required this.requestedBloodGroup,
        required this.city,
        required this.hospital,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.approvedBy,
    });

    final String? id;
    final String? requestedBy;
    final bool? isApproved;
    final bool? isReviewed;
    final String? note;
    final String? requestedBloodGroup;
    final String? city;
    final String? hospital;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final ApprovedBy? approvedBy;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"],
            requestedBy: json["requestedBy"],
            isApproved: json["isApproved"],
            isReviewed: json["isReviewed"],
            note: json["note"],
            requestedBloodGroup: json["requestedBloodGroup"],
            city: json["city"],
            hospital: json["hospital"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            approvedBy: json["approvedBy"] == null ? null : ApprovedBy.fromJson(json["approvedBy"]),
        );
    }

}

class ApprovedBy {
    ApprovedBy({
        required this.fullName,
        required this.email,
        required this.password,
        required this.phoneNumber,
        required this.bloodGroup,
        required this.location,
        required this.role,
        required this.imageUrl,
        required this.isAvailableForDonation,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? fullName;
    final String? email;
    final String? password;
    final String? phoneNumber;
    final String? bloodGroup;
    final Location? location;
    final String? role;
    final String? imageUrl;
    final bool? isAvailableForDonation;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory ApprovedBy.fromJson(Map<String, dynamic> json){ 
        return ApprovedBy(
            fullName: json["fullName"],
            email: json["email"],
            password: json["password"],
            phoneNumber: json["phoneNumber"],
            bloodGroup: json["bloodGroup"],
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            role: json["role"],
            imageUrl: json["imageUrl"],
            isAvailableForDonation: json["isAvailableForDonation"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
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

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            type: json["type"],
            coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
        );
    }

}
