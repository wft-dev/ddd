import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/ModelProvider.dart';
import 'package:daily_dairy_diary/models/Setting.dart';
import 'package:daily_dairy_diary/models/Product.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/provider/setting_controller.dart';
import 'package:daily_dairy_diary/repositories/auth_repository.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class AddProduct extends ConsumerStatefulWidget {
  const AddProduct(this.productData, {Key? key}) : super(key: key);
  final Product? productData;

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

  Setting? settingData;

  List<Product> productList = [];

  DateTime get start => DateTime(_startDate.year, _startDate.month,
      _startDate.day, _startTime.hour, _startTime.minute);
  DateTime get end => DateTime(_endDate.year, _endDate.month, _endDate.day,
      _endTime.hour, _endTime.minute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.add),
        ),
        body: getBody());
  }

  @override
  void initState() {
    super.initState();
    final group = GroupControllers();
    groupControllers.add(group);
  }

  // This method is used for autofill the data from [Setting] and [Product].
  // The [Product] data is used for update the entry and [Setting] data for taking the default value.
  void autofillData<T>(T? item) {
    if (item is Setting) {
      setAutofillData(item.type, item.name!, item.price.toString(),
          item.quantity.toString());
    }
    if (item is Product) {
      setAutofillData(item.type, item.name!, item.price.toString(),
          item.quantity.toString());
    }
  }

  // This method is setting the data in all fields that get from [Setting] or [Product].
  void setAutofillData(
      String? type, String name, String price, String quantity) {
    selectedValue = type;
    groupControllers[0].name.text = name;
    groupControllers[0].price.text = price;
    groupControllers[0].quantity.text = quantity;
  }

  // This is used for display all widgets.
  Widget getBody() {
    ref.listen<AsyncValue>(settingControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      print('state ${state.value}');
    });
    if (widget.productData != null) {
      autofillData(widget.productData);
    } else {
      final settingList = ref.watch(settingControllerProvider);
      print('state112 $settingList');
      settingList.whenData((setting) {
        if (setting.isNotEmpty) {
          final settingItem = setting[0];
          settingData = settingItem;
          autofillData(settingItem);
        }
      });
    }
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
            buildResetButton(),
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

  // This [AppCheckbox] is used for mark the entry as default for setting screen.
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

  // [AppTextFormField]
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

  // [DateTimePicker]
  Widget buildStartDate() {
    return DateTimePicker(
      labelText: Strings.date,
      selectedDate: _startDate,
      selectedTime: _startTime,
      onSelectedDate: (date) => setState(() => _startDate = date),
      onSelectedTime: (time) => setState(() => _startTime = time),
    );
  }

  // [CustomDropdownButton2]
  Widget buildDropDown(int index, String? value,
      [ValueChanged<String?>? onChanged]) {
    return CustomDropdownButton2(
      dropdownItems: items,
      onChanged: onChanged,
      hint: Strings.selectType,
      value: value,
    );
  }

  // This [Form] display name, price, quantity for creating setting product.
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

  // This [AppButton] is used for create the setting product and additional products.
  AppButton buildSaveButton() {
    // final q = ref.watch(settingControllerProvider);
    ref.listen<AsyncValue>(productControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      print('state ${state.value}');
    });
    return AppButton(
      text: Strings.save,
      onPress: () async {
        // if (!_formKey.currentState!.validate() ||
        //     !_moreFormKey.currentState!.validate()) return;
        final userID = ref.read(currentUserRepositoryProvider).value;
        if (userID != null) {
          final now = DateTime.now();
          var product = Product(
            name: groupControllers[0].name.text,
            price: groupControllers[0].price.text.parseInt(),
            type: selectedValue,
            quantity: groupControllers[0].quantity.text.parseInt(),
            date: TemporalDateTime(start),
            userID: userID,
          );
          productList.add(product);
          // var l = productList.map((todo) => todo.toString()).toList();
          // var products = MoreProduct(products: l);
          // List<Product> products = productList
          //         .map((todo) => todo.copyWith(date: TemporalDateTime(now)))
          //     as List<Product>;
          if (settingData == null && isDefault) {
            var setting = Setting(
              name: groupControllers[0].name.text,
              price: groupControllers[0].price.text.parseInt(),
              type: selectedValue,
              quantity: groupControllers[0].quantity.text.parseInt(),
              date: TemporalDateTime(now),
              userID: userID,
              isDefault: isDefault,
            );
            ref.read(settingControllerProvider.notifier).addSetting(setting);
            ref
                .read(productControllerProvider.notifier)
                .addProduct(productList);
          } else if (widget.productData != null) {
            final updatedProductData = widget.productData!.copyWith(
              name: groupControllers[0].name.text,
              price: groupControllers[0].price.text.parseInt(),
              type: selectedValue,
              quantity: groupControllers[0].quantity.text.parseInt(),
              date: TemporalDateTime(now),
              userID: userID,
            );
            ref
                .read(productControllerProvider.notifier)
                .editProduct(updatedProductData);
          } else {
            ref
                .read(productControllerProvider.notifier)
                .addProduct(productList);
          }
        }
      },
    );
  }

  // This [AppButton] is used for add additional products.
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

  // This [AppButton] is used for add reset the inputs for getting back setting products.
  AppButton buildResetButton() {
    return AppButton(
      text: Strings.reset,
      onPress: () {
        if (settingData != null) {
          autofillData(settingData!);
        }
      },
    );
  }

  // This [ListView] is displaying additional products.
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
                    productList[index] = productByIndex.copyWith(
                        type: value, date: TemporalDateTime(start));
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

  @override
  void dispose() {
    for (final controller in groupControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
