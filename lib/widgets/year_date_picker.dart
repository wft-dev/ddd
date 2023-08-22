import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

typedef YdPickerConfirmCallback = void Function(String year);

class YearDatePicker<T> {
  final String title;
  final String doneText;
  final String cancelText;
  String? initialText;

  final VoidCallback? onCancel;
  final YdPickerConfirmCallback? onConfirm;
  final List<T>? pickerList;

  YearDatePicker({
    Key? key,
    this.title = '',
    this.doneText = Strings.done,
    this.cancelText = Strings.cancel,
    this.initialText,
    this.onCancel,
    this.onConfirm,
    this.pickerList,
  });

  void showPicker(BuildContext context) {
    initialText ??= pickerList?[Sizes.pInt0].toString();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            widthFactor: Sizes.p1,
            heightFactor: Sizes.p09,
            child: PickerYdWidget(
              [
                Tab(text: title),
              ],
              onCancel,
              onConfirm,
              doneText,
              cancelText,
              initialText,
              pickerList,
            ),
          );
        });
  }
}

class PickerYdWidget<T> extends StatefulWidget {
  final List<Tab> _tabs;
  final VoidCallback? _onCancel;
  final YdPickerConfirmCallback? _onConfirm;

  final String _doneText;
  final String _cancelText;
  final String? _initialText;

  final List<T>? _pickerList;

  const PickerYdWidget(this._tabs, this._onCancel, this._onConfirm,
      this._doneText, this._cancelText, this._initialText, this._pickerList,
      {Key? key})
      : super(key: key);

  @override
  PickerYdWidgetState createState() => PickerYdWidgetState();
}

class PickerYdWidgetState extends State<PickerYdWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String? selectedText;

  @override
  void initState() {
    super.initState();
    selectedText = widget._initialText;
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
          labelStyle: CustomTextStyle.textFieldLabelStyle()
              .copyWith(fontSize: Sizes.p5.sw),
          labelColor: AppColors.darkPurpleColor,
          indicatorColor: AppColors.darkPurpleColor,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: Sizes.p180,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: ResponsiveAppUtil.width,
                  height: Sizes.p6.sh,
                  margin: EdgeInsets.symmetric(
                      horizontal: Sizes.p4.sw, vertical: Sizes.p2.sh),
                  color: AppColors.alphaPurpleColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.p8, vertical: Sizes.p4),
                    child: Text(
                      selectedText ?? '',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.textFieldLabelStyle()
                          .copyWith(fontSize: Sizes.p4.sw),
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    looping: true,
                    itemExtent: Sizes.p32,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectedText = widget._pickerList?[index].toString();
                      });
                    },
                    children: List<Widget>.generate(years.length, (index) {
                      return Center(
                        child: Text(
                          '${widget._pickerList?[index]}',
                          style: CustomTextStyle.textFieldLabelStyle()
                              .copyWith(fontSize: Sizes.p4.sw),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: Sizes.p1.sh),
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: AppButton(
                    width: Sizes.p20.sw,
                    text: widget._cancelText,
                    onPress: () {
                      Navigator.pop(context);
                      if (widget._onCancel != null) {
                        widget._onCancel!();
                      }
                    },
                  ),
                ),
                Box.gapW2,
                Flexible(
                  child: AppButton(
                    width: Sizes.p20.sw,
                    text: widget._doneText,
                    onPress: () {
                      Navigator.of(context).pop();
                      if (widget._onConfirm != null) {
                        widget._onConfirm!(selectedText!);
                      }
                    },
                  ),
                ),
                Box.gapW2,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
