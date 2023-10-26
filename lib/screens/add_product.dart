import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_dairy_diary/constant/constant.dart';
import 'package:daily_dairy_diary/constant/strings.dart';
import 'package:daily_dairy_diary/models/ModelProvider.dart';
import 'package:daily_dairy_diary/models/result.dart';
import 'package:daily_dairy_diary/provider/inventory_controller.dart';
import 'package:daily_dairy_diary/provider/product_controller.dart';
import 'package:daily_dairy_diary/provider/setting_controller.dart';
import 'package:daily_dairy_diary/repositories/auth_repository.dart';
import 'package:daily_dairy_diary/utils/common_utils.dart';
import 'package:daily_dairy_diary/widgets/all_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct(this.productData, this.selectedDate, {Key? key})
      : super(key: key);
  final Product? productData;
  final DateTime? selectedDate;

  @override
  ConsumerState<AddProduct> createState() => AddProductState();
}

class AddProductState extends ConsumerState<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _moreFormKey = GlobalKey<FormState>();
  List<GroupControllers> groupControllers = [];

  late DateTime buyDate = widget.selectedDate ?? DateTime.now();
  late TimeOfDay buyTime = TimeOfDay.now();
  String? selectedValue;
  bool isDefault = false;
  bool isAddMoreSelected = false;
  bool isDateTimeSelected = false;

  Setting? settingData;

  List<Product> productList = [];
  List<Inventory> inventoryList = inventoryDemoList;

  DateTime get buyDateTime => DateTime(
      buyDate.year, buyDate.month, buyDate.day, buyTime.hour, buyTime.minute);

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppBar(
      barTitle: widget.productData == null ? Strings.add : Strings.update,
      child: getBody(),
    );
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
        item.name ?? '',
        item.price.toString(),
        item.quantity.toString(),
      );
    }
    if (item is Product) {
      setAutofillData(item.type, item.name ?? '', item.price.toString(),
          item.quantity.toString(), item.date!.getDateTimeInUtc());
    }
  }

  // This method is setting the data in all fields that get from [Setting] or [Product].
  void setAutofillData(String? type, String name, String price, String quantity,
      [DateTime? date]) {
    setState(() {
      selectedValue = type;
    });
    groupControllers[Sizes.pInt0].name.text = name;
    groupControllers[Sizes.pInt0].price.text = price;
    groupControllers[Sizes.pInt0].quantity.text = quantity;
    if (date != null && !isDateTimeSelected) {
      buyDate = date.toLocal();
      buyTime = TimeOfDay.fromDateTime(date.toLocal());
    }
  }

  // This is used for display all widgets.
  Widget getBody() {
    ref.watch(settingControllerProvider).isLoadingShow(context);
    ref.listen<AsyncValue>(settingControllerProvider, (_, state) {
      state.showAlertDialogOnError(context: context, ref: ref);
      if (!state.hasError && state.hasValue && !state.isLoading) {
        state.whenData((result) {
          final List? settingResult = result.items;
          if (widget.productData == null) {
            if (settingResult != null && settingResult.isNotEmpty) {
              final settingItem = settingResult[Sizes.pInt0];
              settingData = settingItem;
              autofillData(settingItem);
            }
          }
        });
      }
    });
    getInventoryData();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: Sizes.p5.sw),
      child: Container(
        padding: EdgeInsets.only(bottom: Sizes.p4.sh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRoundedContainer(
              child: Column(
                children: [
                  buildDatePicker(),
                  buildSettingForm(_formKey),
                  if ((widget.productData == null) &&
                      (settingData != null)) ...[
                    Box.gapH2,
                    buildSaveAndResetButton(),
                  ] else ...[
                    if ((settingData == null) &&
                        (widget.productData == null)) ...[
                      buildIsDefaultCheckbox(),
                    ],
                    Box.gapH2,
                    buildSaveButton(),
                  ]
                ],
              ),
            ),
            if (widget.productData == null) ...[
              if (isAddMoreSelected) ...[
                Form(
                  key: _moreFormKey,
                  child: Flexible(
                    // height: 400,
                    child: buildMoreProductListView(),
                  ),
                )
              ],
              Box.gapH2,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.p5.sw),
                child: buildAddMoreButton(),
              ),
              Box.gapH2,
            ]
          ],
        ),
      ),
    );
  }

  //Get [Inventory] data for [AppDropDownFiled].
  getInventoryData() {
    final list = ref.watch(inventoryControllerProvider);
    list.whenData((value) {
      final inventoryResult = value;
      if (inventoryResult.items != null) {
        final List? inventoryItem = inventoryResult.items;
        if (inventoryItem != null && inventoryItem.isNotEmpty) {
          List<Inventory>? inventoryItems = inventoryItem.cast<Inventory>();
          inventoryList = inventoryItems;
        }
      }
    });
    ref.listen<AsyncValue>(settingControllerProvider, (_, state) {
      state.showAlertDialogOnError(context: context, ref: ref);
    });
  }

  // This [Row] is used show add, update and reset buttons.
  Row buildSaveAndResetButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: buildSaveButton(),
        ),
        Box.gapW12,
        Expanded(
          child: buildResetButton(),
        ),
      ],
    );
  }

  // This [AppCheckbox] is used for mark the entry as default for setting screen.
  AppCheckbox buildIsDefaultCheckbox() {
    return AppCheckbox(
      style: CustomTextStyle.textFieldLabelStyle()
          .copyWith(fontWeight: Fonts.fontWeightMedium, fontSize: Sizes.p4.sw),
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
      keyboardType: label == Strings.price || label == Strings.quantity
          ? TextInputType.number
          : TextInputType.text,
      textInputAction: textInputAction,
      onChanged: onChanged,
    );
  }

  // [DateTimePicker]
  DateTimePicker buildDatePicker() {
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
      label: Strings.type,
      dropdownItems: inventoryList,
      onChanged: onChanged,
      hint: Strings.selectType,
      validator: (value) {
        if (value == null) {
          return Validations.validateString('', Strings.type);
        }
        return null;
      },
      value: findInventory(value ?? '', inventoryList),
    );
  }

  // This [Form] display name, price, quantity for creating setting product.
  Form buildSettingForm(Key key) {
    return Form(
      key: key,
      child: Column(
        children: <Widget>[
          buildDropDownFiled(Sizes.pInt0, selectedValue, (value) {
            setState(() {
              selectedValue = value!.type;
              groupControllers[Sizes.pInt0].price.text = value.price.toString();
            });
          }),
          generateTextField(groupControllers[Sizes.pInt0].name, Strings.name,
              TextInputAction.next),
          generateTextField(groupControllers[Sizes.pInt0].price, Strings.price,
              TextInputAction.next),
          generateTextField(groupControllers[Sizes.pInt0].quantity,
              Strings.quantity, TextInputAction.done),
        ],
      ),
    );
  }

  // This [AppButton] is used for create the setting product and additional products.
  AppButton buildSaveButton() {
    ref.listen<AsyncValue>(productControllerProvider, (_, state) {
      state.showAlertDialogOnError(context: context, ref: ref);
      state.whenData((product) {
        final Result productResult = product;
        if (productResult.actionType == ActionType.add) {
          showAlertActionDialog(
            context: context,
            title: Strings.success,
            content: Strings.successMessage(
                Strings.product, productResult.actionType.name),
            onYesPress: () => context.pop(),
          );
        }
        if (productResult.actionType == ActionType.update) {
          ShowSnackBar.showSnackBar(
              context,
              Strings.successMessage(
                  Strings.product, productResult.actionType.name));
        }
      });
    });
    return AppButton(
      text: Strings.save,
      onPress: () async {
        if (isAddMoreSelected) {
          if (!_formKey.currentState!.validate() ||
              !_moreFormKey.currentState!.validate()) return;
        } else {
          if (!_formKey.currentState!.validate()) return;
        }

        final userID = ref.read(currentUserRepositoryProvider).value;
        if (userID != null) {
          var product = Product(
            name: groupControllers[Sizes.pInt0].name.text,
            price: groupControllers[Sizes.pInt0].price.text.parseInt(),
            type: selectedValue,
            quantity: groupControllers[Sizes.pInt0].quantity.text.parseInt(),
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
              name: groupControllers[Sizes.pInt0].name.text,
              price: groupControllers[Sizes.pInt0].price.text.parseInt(),
              type: selectedValue,
              quantity: groupControllers[Sizes.pInt0].quantity.text.parseInt(),
              date: TemporalDateTime(buyDateTime),
              userID: userID,
              isDefault: isDefault,
            );
            await ref
                .read(settingControllerProvider.notifier)
                .addSetting(setting);
            await ref
                .read(productControllerProvider.notifier)
                .addProduct(productList);
            productList.clear();
          } else if (widget.productData != null) {
            final updatedProductData = widget.productData!.copyWith(
              name: groupControllers[Sizes.pInt0].name.text,
              price: groupControllers[Sizes.pInt0].price.text.parseInt(),
              type: selectedValue,
              quantity: groupControllers[Sizes.pInt0].quantity.text.parseInt(),
              date: TemporalDateTime(buyDateTime),
              userID: userID,
            );
            await ref
                .read(productControllerProvider.notifier)
                .editProduct(updatedProductData);
          } else {
            await ref
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
          isAddMoreSelected = true;
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
      shrinkWrap: true,
      primary: false,
      itemCount: productList.length,
      itemBuilder: (BuildContext context, int index) {
        int indexForList = index + 1;
        Product productByIndex = productList[index];
        return buildRoundedContainer(
          child: SizedBox(
            // height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDropDownFiled(indexForList, productList[index].type,
                    (value) {
                  setState(() {
                    productList[index] = productByIndex.copyWith(
                        type: value!.type,
                        date: TemporalDateTime(buyDateTime),
                        price: value.price);
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
                Box.gapH2,
                AppButton(
                  text: Strings.remove,
                  onPress: () {
                    setState(() {
                      if (_moreFormKey.currentState != null) {
                        _moreFormKey.currentState?.reset();
                      }
                      groupControllers.removeAt(indexForList);
                      productList.removeAt(index);
                      if (productList.length == Sizes.pInt0) {
                        isAddMoreSelected = false;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (final controller in groupControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
