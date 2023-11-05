
import 'package:catering/Refactoring/widgets/others.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Refactoring/methods/logout_box.dart';
import '../../Refactoring/styles/colors.dart';
import '../../Refactoring/widgets/elevated_button.dart';
import 'work/add_work.dart';
import 'boys_history.dart';
import 'edit_profile.dart';
import 'work/work_history.dart';

class AHomePage extends StatelessWidget {
  const AHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 28, 27),
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text('ADMIN',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                logoutDialog();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ScrollConfiguration(
        behavior: RemoveGlow(),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
               return CostumEButton(
                gradient: costumGradient(Alignment.bottomRight,Alignment.topLeft),
                radius: 10,
                  label: 'Add Work',
                  onChanged: () {
                    Get.to(() => AddWork());
                  },
                );
              }
              if (index == 1) {
               return CostumEButton(
                 gradient: costumGradient(Alignment.bottomLeft,Alignment.topRight),
                radius: 10,
                  label: 'Work History',
                  onChanged: () {
                    Get.to(() => WorkHistory());
                  },
                );
              }
              if (index == 2) {
               return CostumEButton(
                 gradient: costumGradient(Alignment.topRight,Alignment.bottomLeft),
                radius: 10,
                  label: 'Boys History',
                  onChanged: () {
                    Get.to(() => BoysHistory());
                  },
                );
              }
              if (index == 3) {
                return CostumEButton(
                   gradient: costumGradient(Alignment.topLeft,Alignment.bottomRight),
                  radius: 10,
                  label: 'Edit Profile',
                  onChanged: () {
                    Get.to(() => EditProfile());
                  },
                );
              }
              return const SizedBox.shrink();
            },
            itemCount: 4,
          ),
        ),
      ),
    );
  }
}
