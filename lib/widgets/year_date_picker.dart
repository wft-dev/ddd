import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

typedef PickerConfirmCallback = void Function(String year);

final int currentYear = DateTime.now().year;
final List<int> years =
    List.generate(currentYear - 1949, (index) => 1950 + index)
        .reversed
        .toList();

class YearDatePicker {
  final String title;
  final String doneText;
  final String cancelText;

  final VoidCallback? onCancel;
  final PickerConfirmCallback? onConfirm;

  YearDatePicker({
    Key? key,
    this.title = "Year",
    this.doneText = "Done",
    this.cancelText = "Cancel",
    this.onCancel,
    this.onConfirm,
  });

  void showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.8,
            child: PickerWidget(
              [
                Tab(text: title),
              ],
              onCancel,
              onConfirm,
              doneText,
              cancelText,
            ),
          );
        });
  }
}

class PickerWidget extends StatefulWidget {
  final List<Tab> _tabs;
  final VoidCallback? _onCancel;
  final PickerConfirmCallback? _onConfirm;

  final String _doneText;
  final String _cancelText;

  const PickerWidget(this._tabs, this._onCancel, this._onConfirm,
      this._doneText, this._cancelText,
      {Key? key})
      : super(key: key);

  @override
  PickerWidgetState createState() => PickerWidgetState();
}

class PickerWidgetState extends State<PickerWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget._tabs.length);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: TabBar(
          controller: _tabController,
          tabs: widget._tabs,
          labelColor: Theme.of(context).primaryColor,
        ),
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
                    if (widget._onCancel != null) {
                      widget._onCancel!();
                    }
                  },
                  child: Text(widget._cancelText),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (widget._onConfirm != null) {
                      widget._onConfirm!('');
                    }
                  },
                  child: Text(widget._doneText),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
