import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

final int currentYear = DateTime.now().year;
final List<int> years =
    List.generate(currentYear - 1949, (index) => 1950 + index)
        .reversed
        .toList();

class yearDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.8,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: 320,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    width: ResponsiveAppUtil.width,
                    height: Sizes.p4.sh,
                    margin: EdgeInsets.symmetric(
                        horizontal: Sizes.p4.sw, vertical: Sizes.p2.sh),
                    color: bgColor,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(50),
                    //     border:
                    //         Border.all(color: Colors.redAccent, width: 1)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        'tes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent:
                          32.0, // Set the height of each item in the picker
                      onSelectedItemChanged: (int index) {
                        // Handle the selected year here (e.g., save it to a variable)
                        int selectedYear = years[index];
                        print(selectedYear);
                      },
                      children: List<Widget>.generate(years.length, (index) {
                        return Center(
                          child: Text(
                            '${years[index]}',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // if (widget._onCancel != null) {
                      //   widget._onCancel!();
                      // }
                    },
                    child: const Text('widget._cancelText'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // if (widget._onConfirm != null) {
                      //   widget._onConfirm!(_start!, _end!);
                      // }
                    },
                    child: const Text('widget._doneText'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
