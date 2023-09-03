import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../theme.dart';

class PolicyDialog extends StatelessWidget {
  PolicyDialog({
    Key? key,
    this.radius = 8,
    required this.mdFileName,
  })  : assert(mdFileName.contains('.md'),
  'The file should contain .md extension'),
        super(key: key);
  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 150)).then((value) {
                return rootBundle.loadString('images/$mdFileName');
              }),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(primaryButtonColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(radius),
                              bottomRight: Radius.circular(radius))))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                ),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: const Text(
                  "Accept",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    // backgroundColor: backgroundColor,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}