import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/ModelProvider.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/provider/setting_controller.dart';
import 'package:daily_dairy_diary/repositories/auth_repository.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

  late DateTime buyDate = DateTime.now();
  late TimeOfDay buyTime = TimeOfDay.now();
  String? selectedValue;
  static const int indexForSingleView = 0;
  bool isDefault = false;
  bool isDateTimeSelected = false;

  Setting? settingData;

  List<Product> productList = [];

  DateTime get buyDateTime => DateTime(
      buyDate.year, buyDate.month, buyDate.day, buyTime.hour, buyTime.minute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.productData == null ? Strings.add : Strings.update),
        ),
        body: getBody());
  }

  @override
  void initState() {
    super.initState();

    final group = GroupControllers();
    groupControllers.add(group);
    if (widget.productData != null) {
      autofillData(widget.productData);
    }
  }

  // This method is used for autofill the data from [Setting] and [Product].
  // The [Product] data is used for update the entry and [Setting] data for taking the default value.
  void autofillData<T>(T? item) {
    if (item is Setting) {
      setAutofillData(
        item.type,
        item.name!,
        item.price.toString(),
        item.quantity.toString(),
      );
    }
    if (item is Product) {
      setAutofillData(item.type, item.name!, item.price.toString(),
          item.quantity.toString(), item.date!.getDateTimeInUtc());
    }
  }

  // This method is setting the data in all fields that get from [Setting] or [Product].
  void setAutofillData(String? type, String name, String price, String quantity,
      [DateTime? date]) {
    setState(() {
      selectedValue = type;
    });
    groupControllers[0].name.text = name;
    groupControllers[0].price.text = price;
    groupControllers[0].quantity.text = quantity;
    if (date != null && !isDateTimeSelected) {
      buyDate = date.toLocal();
      buyTime = TimeOfDay.fromDateTime(date.toLocal());
    }
  }

  // This is used for display all widgets.
  Widget getBody() {
    ref.listen<AsyncValue>(settingControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData((result) {
          final List<Setting?> settings = result;
          if (widget.productData == null) {
            if (settings.isNotEmpty) {
              final settingItem = settings[0];
              settingData = settingItem;
              autofillData(settingItem);
            }
          }
        });
      }
    });

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
            buildDatePicker(),
            buildDropDownFiled(indexForSingleView, selectedValue, (value) {
              setState(() {
                selectedValue = value!.type;
                groupControllers[0].price.text = value.price.toString();
              });
            }),
            buildSettingForm(_formKey),
            if (widget.productData == null) ...[
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
            ] else
              buildSaveButton(),
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
  Widget buildDatePicker() {
    return DateTimePicker(
      dateLabelText: Strings.date,
      timeLabelText: Strings.time,
      selectedDate: buyDate,
      selectedTime: buyTime,
      onSelectedDate: (date) => setState(() {
        buyDate = date;
        isDateTimeSelected = true;
      }),
      onSelectedTime: (time) => setState(() {
        buyTime = time;
        isDateTimeSelected = true;
      }),
    );
  }

  // [AppDropDownFiled]
  AppDropDownFiled buildDropDownFiled(int index, String? value,
      [ValueChanged<Inventory?>? onChanged]) {
    return AppDropDownFiled<Inventory>(
      dropdownItems: inventoryList,
      onChanged: onChanged,
      hint: Strings.selectType,
      value: findInventory(selectedValue ?? ''),
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
      state.whenData((value) {
        showExceptionAlertDialog(
          context: context,
          title: Strings.success,
          exception: Strings.success,
        );
      });
      // ShowSnackBar.showSnackBar(context, 'message');
    });
    return AppButton(
      text: Strings.save,
      onPress: () async {
        if (widget.productData == null) {
          if (!_formKey.currentState!.validate() ||
              !_moreFormKey.currentState!.validate()) return;
        } else {
          if (!_formKey.currentState!.validate()) return;
        }

        final userID = ref.read(currentUserRepositoryProvider).value;
        if (userID != null) {
          var product = Product(
            name: groupControllers[0].name.text,
            price: groupControllers[0].price.text.parseInt(),
            type: selectedValue,
            quantity: groupControllers[0].quantity.text.parseInt(),
            date: TemporalDateTime(buyDateTime),
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
              date: TemporalDateTime(buyDateTime),
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
              date: TemporalDateTime(buyDateTime),
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
                buildDropDownFiled(index, productList[index].type, (value) {
                  setState(() {
                    productList[index] = productByIndex.copyWith(
                        type: value!.type, date: TemporalDateTime(buyDateTime));
                    groupControllers[indexForList].price.text =
                        value.price.toString();
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
