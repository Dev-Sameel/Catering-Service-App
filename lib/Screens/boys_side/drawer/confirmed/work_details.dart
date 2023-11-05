import 'package:catering/Refactoring/methods/app_bar_cuper.dart';
import 'package:catering/Refactoring/widgets/others.dart';
import 'package:flutter/material.dart';

import '../../../../Refactoring/methods/work_card_details.dart';
import '../../../../Refactoring/styles/colors.dart';
import '../../../../model/add_work_model.dart';

class WorkDetails extends StatelessWidget {
  final String? uID;
  final AddWorkModel workDetails;
  final int? windex;
  const WorkDetails({super.key, required this.workDetails,this.windex,this.uID});

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      backgroundColor: bgColor,
      appBar:customAppBar(null, null, null, 'WORK DETAILS'),
      
      body: ScrollConfiguration(
        behavior: RemoveGlow(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return workCardDetails('View Work Details', index, context,
                    'assets/images/Icons/details.png',workDetails,windex,uID);
              } else if (index == 1) {
                return workCardDetails('SetUp Bus Fare', index, context,
                    'assets/images/Icons/busfare.png',null,windex,uID);
              }
              return const SizedBox
                  .shrink(); // Return an empty widget if more than two items are needed.
            },
            itemCount: 2,
          ),
        ),
      ),
    );
  }
}
