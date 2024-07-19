import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  index.toString(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
