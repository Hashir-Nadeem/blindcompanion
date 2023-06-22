import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBlindCallRequestContainer extends StatefulWidget {
  const MyBlindCallRequestContainer(
      {super.key,
      required this.text,
      required this.callType,
      required this.uid,
      required this.ontap,
      required this.ontaprej});
  final String text;
  final String? callType;
  final uid;
  final void Function() ontap;
  final void Function() ontaprej;

  @override
  State<MyBlindCallRequestContainer> createState() =>
      _MyBlindCallRequestContainerState();
}

class _MyBlindCallRequestContainerState
    extends State<MyBlindCallRequestContainer> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return (Container(
      height: screenHeight * 0.2,
      width: screenWidth * 1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green)),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  Text(
                    widget.text.capitalize ?? 'Error',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  Wrap(children: [
                    Text(
                      widget.callType?.capitalize ?? 'Error',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: widget.ontap
                // () {
                //   Globalcheck.brief = false;
                //   setState(() {
                //     updateBriefCallStatus();
                //     GetDocuments.getDocumentsData();
                //   });
                //   AppNavigation.push(
                //       context,
                //       CallPage(
                //         callID: widget.uid,
                //       ));
                // },
                ,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  'Accept',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: widget.ontaprej
                //  () {
                //   updateBriefCallStatus();
                //   setState(() {
                //     GetDocuments.getDocumentsData();
                //   });
                //   Navigator.pop(context);
                //   AppNavigation.push(context, MyVolunteerScreen());
                // }
                ,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  'Reject',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ));
  }
}

class Globalcheck {
  static bool brief = false;
}
