import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/models/Setting.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/repositories/auth_repository.dart';
import 'package:daily_dairy_diary/repositories/product_repository.dart';
import 'package:daily_dairy_diary/repositories/setting_repository.dart';
import 'package:daily_dairy_diary/widgets/app_drop_down.dart';
import 'package:daily_dairy_diary/widgets/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/strings.dart';
import '../utils/common_utils.dart';
import '../widgets/all_widgets.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});
  @override
  ConsumerState<AddProduct> createState() => AddProductState();
}

class AddProductState extends ConsumerState<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _moreFormKey = GlobalKey<FormState>();
  List<GroupControllers> groupControllers = [];

  late DateTime _startDate = DateTime.now();
  late TimeOfDay _startTime = TimeOfDay.now();
  late DateTime _endDate;
  late TimeOfDay _endTime;
  String? selectedValue;
  static const int indexForSingleView = 0;
  bool isDefault = false;

  final List<String> items = [
    'Milk',
    'Curd',
    'Bread',
    'Sugar',
  ];

  List<Product> productList = [];

  DateTime get start => DateTime(_startDate.year, _startDate.month,
      _startDate.day, _startTime.hour, _startTime.minute);
  DateTime get end => DateTime(_endDate.year, _endDate.month, _endDate.day,
      _endTime.hour, _endTime.minute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.register),
        ),
        body: getBody());
  }

  @override
  void initState() {
    super.initState();
    final group = GroupControllers();
    groupControllers.add(group);
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100.0, //viewportConstraints.maxHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "",
              style: CustomTextStyle.loginTitleStyle().copyWith(fontSize: 36),
            ),
            buildStartDate(),
            buildDropDown(indexForSingleView, selectedValue, (value) {
              setState(() {
                selectedValue = value;
              });
            }),
            buildSettingForm(_formKey),
            buildIsDefaultCheckbox(),
            gapH12,
            buildSaveButton(),
            gapH12,
            buildAddMoreButton(),
            gapH12,
            Form(
              key: _moreFormKey,
              child: Flexible(
                // height: 400,
                child: buildMoreProductListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppCheckbox buildIsDefaultCheckbox() {
    return AppCheckbox(
      listTileCheckBox: isDefault,
      title: Strings.markDefault,
      onChange: (value) async {
        setState(() {
          isDefault = !isDefault;
        });
      },
    );
  }

  AppTextFormField generateTextField(TextEditingController controller,
      String label, TextInputAction textInputAction,
      [ValueChanged<String>? onChanged]) {
    return AppTextFormField(
      controller: controller,
      label: label,
      validator: (value) => Validations.validateString(value, label),
      textInputAction: textInputAction,
      onChanged: onChanged,
    );
  }

  Widget buildStartDate() {
    return DateTimePicker(
      labelText: Strings.date,
      selectedDate: _startDate,
      selectedTime: _startTime,
      onSelectedDate: (date) => setState(() => _startDate = date),
      onSelectedTime: (time) => setState(() => _startTime = time),
    );
  }

  Widget buildDropDown(int index, String? value,
      [ValueChanged<String?>? onChanged]) {
    return CustomDropdownButton2(
      dropdownItems: items,
      onChanged: onChanged,
      hint: 'Select Item',
      value: value,
    );
  }

  Form buildSettingForm(Key key) {
    return Form(
      key: key,
      child: Column(
        children: <Widget>[
          generateTextField(groupControllers[indexForSingleView].name,
              Strings.name, TextInputAction.next),
          generateTextField(groupControllers[indexForSingleView].price,
              Strings.price, TextInputAction.next),
          generateTextField(groupControllers[indexForSingleView].quantity,
              Strings.quantity, TextInputAction.done),
        ],
      ),
    );
  }

  AppButton buildSaveButton() {
    return AppButton(
      text: Strings.save,
      onPress: () async {
        if (!_formKey.currentState!.validate() &&
            !_moreFormKey.currentState!.validate()) return;

        final userID = ref.read(currentUserRepositoryProvider).value;
        if (userID != null) {
          final now = DateTime.now();
          var setting = Setting(
            name: groupControllers[0].name.text,
            price: groupControllers[0].price.text.parseInt(),
            type: selectedValue,
            quantity: groupControllers[0].quantity.text.parseInt(),
            date: TemporalDateTime(now),
            userID: userID,
            isDefault: isDefault,
          );
          // ref.read(SettingRepositoryP).createProduct(setting);
        }
      },
    );
  }

  AppButton buildAddMoreButton() {
    return AppButton(
      text: Strings.addMore,
      onPress: () {
        final group = GroupControllers();
        setState(() {
          groupControllers.add(group);
          productList.add(Product(userID: ''));
        });
      },
    );
  }

  // There is a list of more products.
  ListView buildMoreProductListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        primary: false,
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          int indexForList = index + 1;
          Product productByIndex = productList[index];
          return SizedBox(
            // height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "",
                  style:
                      CustomTextStyle.loginTitleStyle().copyWith(fontSize: 36),
                ),
                buildDropDown(index, productList[index].type, (value) {
                  setState(() {
                    productList[index] = productByIndex.copyWith(type: value);
                  });
                }),
                generateTextField(groupControllers[indexForList].name,
                    Strings.name, TextInputAction.next, (value) {
                  setState(() {
                    productList[index] = productByIndex.copyWith(name: value);
                  });
                }),
                generateTextField(groupControllers[indexForList].price,
                    Strings.price, TextInputAction.next, (value) {
                  setState(() {
                    productList[index] =
                        productByIndex.copyWith(price: value.parseInt());
                  });
                }),
                generateTextField(groupControllers[indexForList].quantity,
                    Strings.quantity, TextInputAction.done, (value) {
                  setState(() {
                    productList[index] =
                        productByIndex.copyWith(quantity: value.parseInt());
                  });
                }),
                AppButton(
                  text: Strings.remove,
                  onPress: () {
                    final group = GroupControllers();
                    setState(() {
                      groupControllers.add(group);
                      productList.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  // dispose
  @override
  void dispose() {
    for (final controller in groupControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

/// These [GroupControllers] are used for name, price, quantity as [TextEditingController].
class GroupControllers {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();

  void dispose() {
    name.dispose();
    price.dispose();
    quantity.dispose();
  }
}
