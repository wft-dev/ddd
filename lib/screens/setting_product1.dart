// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:daily_dairy_diary/constant/constant.dart';
// import 'package:daily_dairy_diary/constant/strings.dart';
// import 'package:daily_dairy_diary/models/Inventory.dart';
// import 'package:daily_dairy_diary/models/Setting.dart';
// import 'package:daily_dairy_diary/models/Product.dart';
// import 'package:daily_dairy_diary/provider/product_controller.dart';
// import 'package:daily_dairy_diary/provider/setting_controller.dart';
// import 'package:daily_dairy_diary/repositories/auth_repository.dart';
// import 'package:daily_dairy_diary/utils/common_utils.dart';
// import 'package:daily_dairy_diary/widgets/all_widgets.dart';
// import 'package:daily_dairy_diary/widgets/loading_overlay.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:responsive_builder/responsive_builder.dart';

// class SettingProduct extends ConsumerStatefulWidget {
//   const SettingProduct({super.key});
//   @override
//   ConsumerState<SettingProduct> createState() => SettingProductState();
// }

// class SettingProductState extends ConsumerState<SettingProduct> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   List<GroupControllers> groupControllers = [];

//   late DateTime _startDate = DateTime.now();
//   late TimeOfDay _startTime = TimeOfDay.now();
//   late DateTime _endDate;
//   late TimeOfDay _endTime;
//   String? selectedValue;
//   static const int indexForSingleView = 0;
//   bool isDefault = false;

//   Setting? settingData;

//   DateTime get start => DateTime(_startDate.year, _startDate.month,
//       _startDate.day, _startTime.hour, _startTime.minute);
//   DateTime get end => DateTime(_endDate.year, _endDate.month, _endDate.day,
//       _endTime.hour, _endTime.minute);

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldAppBar(
//       barTitle: Strings.setting,
//       child: getBody(),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     // ref.read(settingControllerProvider.notifier).fetchData();
//     final group = GroupControllers();
//     groupControllers.add(group);
//   }

//   // This is used for display all widgets.
//   Widget getBody() {
//     ref.listen<AsyncValue>(settingControllerProvider, (_, state) {
//       state.showAlertDialogOnError(context);
//       print('state ${state.value}');
//     });

//     final settingList = ref.watch(settingControllerProvider);
//     print('state112 $settingList');
//     settingList.whenData((setting) {
//       if (setting.isNotEmpty) {
//         final settingItem = setting[Sizes.pInt0]!;
//         settingData = settingItem;
//         selectedValue = settingItem.type;
//         groupControllers[Sizes.pInt0].name.text = settingItem.name!;
//         groupControllers[Sizes.pInt0].price.text = settingItem.price.toString();
//         groupControllers[Sizes.pInt0].quantity.text =
//             settingItem.quantity.toString();
//       }
//     });
//     return Container(
//       height: ResponsiveAppUtil.height * Sizes.p01.sh,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius:
//             BorderRadius.vertical(bottom: Radius.circular(Sizes.p12.sw)),
//       ),
//       child: Container(
//         margin: EdgeInsets.only(
//             bottom: Sizes.p4.sh, left: Sizes.p5.sw, right: Sizes.p5.sw),
//         padding: EdgeInsets.only(
//             top: Sizes.p2.sh,
//             bottom: Sizes.p2.sh,
//             left: Sizes.p5.sw,
//             right: Sizes.p5.sw),
//         decoration: BoxDecoration(
//           color: AppColors.alphaPurpleColor,
//           borderRadius: BorderRadius.all(Radius.circular(Sizes.p12.sw)),
//         ),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.only(bottom: Sizes.p4.sh),
//           child: buildRoundedContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 buildStartDate(),
//                 buildDropDownFiled(indexForSingleView, selectedValue, (value) {
//                   setState(() {
//                     selectedValue = value!.type;
//                     groupControllers[Sizes.pInt0].price.text =
//                         value.price.toString();
//                   });
//                 }),
//                 buildSettingForm(_formKey),
//                 Box.gapH2,
//                 buildSaveButton(),
//                 Box.gapH2,
//                 buildRemoveButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // [AppTextFormField]
//   AppTextFormField generateTextField(TextEditingController controller,
//       String label, TextInputAction textInputAction,
//       [ValueChanged<String>? onChanged]) {
//     return AppTextFormField(
//       controller: controller,
//       label: label,
//       validator: (value) => Validations.validateString(value, label),
//       textInputAction: textInputAction,
//       onChanged: onChanged,
//     );
//   }

//   // [DateTimePicker]
//   Widget buildStartDate() {
//     return DateTimePicker(
//       dateLabelText: Strings.date,
//       timeLabelText: Strings.time,
//       selectedDate: _startDate,
//       selectedTime: _startTime,
//       onSelectedDate: (date) => setState(() => _startDate = date),
//       onSelectedTime: (time) => setState(() => _startTime = time),
//     );
//   }

//   // [AppDropDownFiled]
//   AppDropDownFiled buildDropDownFiled(int index, String? value,
//       [ValueChanged<Inventory?>? onChanged]) {
//     return AppDropDownFiled<Inventory>(
//       dropdownItems: inventoryList,
//       onChanged: onChanged,
//       hint: Strings.selectType,
//       value: findInventory(selectedValue ?? ''),
//     );
//   }

//   // This [Form] display name, price, quantity for creating setting product.
//   Form buildSettingForm(Key key) {
//     return Form(
//       key: key,
//       child: Column(
//         children: <Widget>[
//           generateTextField(groupControllers[indexForSingleView].name,
//               Strings.name, TextInputAction.next),
//           generateTextField(groupControllers[indexForSingleView].price,
//               Strings.price, TextInputAction.next),
//           generateTextField(groupControllers[indexForSingleView].quantity,
//               Strings.quantity, TextInputAction.done),
//         ],
//       ),
//     );
//   }

//   // This [AppButton] is used for create and update the setting product.
//   AppButton buildSaveButton() {
//     return AppButton(
//       text: settingData != null ? Strings.update : Strings.save,
//       onPress: () async {
//         if (!_formKey.currentState!.validate()) return;
//         final userID = ref.read(currentUserRepositoryProvider).value;
//         if (userID != null) {
//           final now = DateTime.now();
//           if (settingData != null) {
//             final updateSettingData = settingData!.copyWith(
//               name: groupControllers[Sizes.pInt0].name.text,
//               price: groupControllers[Sizes.pInt0].price.text.parseInt(),
//               type: selectedValue,
//               quantity: groupControllers[Sizes.pInt0].quantity.text.parseInt(),
//               date: TemporalDateTime(now),
//               userID: userID,
//               isDefault: true,
//             );
//             ref
//                 .read(settingControllerProvider.notifier)
//                 .editSetting(updateSettingData);
//           } else {
//             var setting = Setting(
//               name: groupControllers[Sizes.pInt0].name.text,
//               price: groupControllers[Sizes.pInt0].price.text.parseInt(),
//               type: selectedValue,
//               quantity: groupControllers[Sizes.pInt0].quantity.text.parseInt(),
//               date: TemporalDateTime(now),
//               userID: userID,
//               isDefault: true,
//             );
//             ref.read(settingControllerProvider.notifier).addSetting(setting);
//           }
//         }
//       },
//     );
//   }

//   // This [AppButton] is used for remove the setting product.
//   AppButton buildRemoveButton() {
//     return AppButton(
//         text: Strings.remove,
//         onPress: () async {
//           ref
//               .read(settingControllerProvider.notifier)
//               .removeSetting(settingData!);
//         });
//   }

//   @override
//   void dispose() {
//     for (final controller in groupControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }
