import 'package:flutter/material.dart';

class MyDoubleIconTextButton extends StatelessWidget {
  const MyDoubleIconTextButton(
      {super.key,
      required this.text,
        this.image,
      required this.color,
      required this.ontap,
      this.textcolor = Colors.white,
      this.desc = "",
        this.isIconRequired = true,
        this.isLeadingImageRequired = true
      });
  final String? image;
  final String text;
  final Color color;
  final Color textcolor;
  final String desc;
  final void Function() ontap;
  final bool isIconRequired;
  final bool isLeadingImageRequired;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    // TODO: implement build
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double fontSize = constraints.maxWidth *
            0.05; // Adjust the multiplication factor as per your preference
        TextStyle textStyle = TextStyle(
            fontSize: fontSize, color: textcolor, fontWeight: FontWeight.bold);

        return FractionallySizedBox(
            // widthFactor: 0.9, // Adjust the width factor as per your preference
            child: InkWell(
                onTap: ontap,
                child: Container(
                  height: screenHeight * 0.10,
                  width: screenSize.width * 0.9,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: isLeadingImageRequired ? Image.asset(
                          image ?? "",
                          fit: BoxFit.cover,
                          height: screenHeight * 0.06,
                        ) : null
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: textStyle,
                            ),
                            desc.isNotEmpty
                                ? Text(
                                    desc,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: textStyle.copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: constraints.maxWidth * 0.04),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      isIconRequired ? const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ) : SizedBox.shrink()
                    ],
                  ),
                )));
      },
    );
  }
}
