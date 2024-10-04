import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserLoadingSkeletonizer extends StatelessWidget {
  const UserLoadingSkeletonizer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.height * 0.001,
            ),
            child: Card(
              elevation: 5,
              child: SizedBox(
                height: size.height * 0.2,
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(size.width),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.grey.shade200,
                            height: size.height * 0.02,
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            height: size.height * 0.02,
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            height: size.height * 0.02,
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            height: size.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
