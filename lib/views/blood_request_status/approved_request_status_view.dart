import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovedRequestStatusView extends StatefulWidget {
  const ApprovedRequestStatusView({super.key});

  @override
  State<ApprovedRequestStatusView> createState() => _ApprovedRequestStatusViewState();
}

class _ApprovedRequestStatusViewState extends State<ApprovedRequestStatusView> {


  @override
  void initState() {
    Get.find<BloodRequestController>().fetchApprovedBloodRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<BloodRequestController>(
      builder: (controller){
        if(controller.isApprovedBloodRequestLoading.value){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(controller.approvedBloodRequestModel != null){
          return ListView.builder(
            itemCount: controller.approvedBloodRequestModel!.data.length,
            itemBuilder: (context,index){
              return ExpansionTile(
                title: Text(controller.approvedBloodRequestModel!.data[index].note ?? "Blood Request"),
                children: [
                  ListTile(
                    title: const Text("Requested Blood Group"),
                    subtitle: Text(controller.approvedBloodRequestModel!.data[index].requestedBloodGroup ?? "",),
                    leading: const Icon(Icons.bloodtype),
                  ),
                  ListTile(
                    title: const Text("Requested City"),
                    subtitle: Text(controller.approvedBloodRequestModel!.data[index].city ?? "",),
                    leading: const Icon(Icons.location_city),
                  ),
                  ListTile(
                    title: const Text("Hospital"),
                    leading: const Icon(Icons.local_hospital,),
                    subtitle: Text(controller.approvedBloodRequestModel!.data[index].hospital ?? ""),
                  ),
                  
                  const Divider(),
                  ListTile(
                    title: const Text("Approved By"),
                    subtitle: Text(controller.approvedBloodRequestModel!.data[index].approvedBy!.fullName ?? ""),
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(controller.approvedBloodRequestModel!.data[index].approvedBy!.imageUrl!,),
                    ),
                  ),
                  ListTile(
                    title: const Text("Email"),
                    leading: const Icon(Icons.email),
                    subtitle: Text(controller.approvedBloodRequestModel!.data[index].approvedBy!.email?? ""),
                  ),
                  ListTile(
                    title: const Text("Contact Number"),
                    leading: const Icon(Icons.phone,),
                    subtitle: Text(controller.approvedBloodRequestModel!.data[index].approvedBy!.phoneNumber?? "",),
                  ),
                  ListTile(
                    title: const Text("Approved At"),
                    leading: const Icon(Icons.date_range,),
                    subtitle: Text("${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).year}-${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).month}-${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).day} / ${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).hour}: ${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).minute}"),
                  ),
                ],
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}