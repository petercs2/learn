import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:get/get.dart';

import '../../main.dart';

class SecondItem extends StatelessWidget {
  const SecondItem(this.maxCount, this.currentCount, this.index, {Key? key})
      : super(key: key);
  final int maxCount;
  final int currentCount;
  final int index;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: <Widget>[
        Text(
          achievements[index],
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        maxCount <= currentCount
            ? <Widget>[
                const Icon(
                  Icons.check_circle_outline,
                  size: 25,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ].toRow()
            : SizedBox(
                width: 166,
                child: <Widget>[
                  <Widget>[
                    Container(
                      width: double.infinity,
                      height: 4,
                    ).decorated(color: Colors.white),
                    Container(
                      width: 166 * (currentCount / maxCount),
                      height: 4,
                    ).decorated(color: Colors.blue),
                  ].toStack()
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ),
        Text(
          'Schedule: $currentCount/$maxCount',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        )
      ].toColumn(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start),
    )
        .decorated(
          image: DecorationImage(image: AssetImage('assets/icon$index.webp')),
          borderRadius: BorderRadius.circular(12),
        )
        .marginOnly(bottom: 10);
  }
}
