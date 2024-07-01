// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:daily_dairy_diary/models/MoreProduct.dart';
// import 'package:daily_dairy_diary/models/Product.dart';
// import 'package:daily_dairy_diary/repositories/auth_repository.dart';
// import 'package:daily_dairy_diary/repositories/product_repository.dart';
// import 'package:daily_dairy_diary/widgets/app_drop_down.dart';
// import 'package:daily_dairy_diary/widgets/date_time_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:responsive_builder/responsive_builder.dart';

// import '../constant/strings.dart';
// import '../utils/common_utils.dart';
// import '../widgets/all_widgets.dart';

// class Setting extends ConsumerStatefulWidget {
//   const Setting({super.key});
//   @override
//   ConsumerState<Setting> createState() => SettingState();
// }

// class SettingState extends ConsumerState<Setting> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _moreFormKey = GlobalKey<FormState>();

//   final TextEditingController priceController = TextEditingController(text: "");
//   final TextEditingController quantityController =
//       TextEditingController(text: "");
//   final TextEditingController typeController = TextEditingController(text: "");

//   List<AppTextFormField> priceFields = [];
//   List<AppTextFormField> quantityFields = [];
//   List<GroupControllers> groupControllers = [];
//   // List<String?>? selectedValue = [];

//   late DateTime _startDate = DateTime.now();
//   late TimeOfDay _startTime = TimeOfDay.now();
//   late DateTime _endDate;
//   late TimeOfDay _endTime;
//   String? selectedValue;
//   static const int indexForDropDown = 0;

//   final List<String> items = [
//     'Milk',
//     'Curd',
//     'Bread',
//     'Sugar',
//   ];

//   List<MoreProduct> moreProductList = [];

//   DateTime get start => DateTime(_startDate.year, _startDate.month,
//       _startDate.day, _startTime.hour, _startTime.minute);
//   DateTime get end => DateTime(_endDate.year, _endDate.month, _endDate.day,
//       _endTime.hour, _endTime.minute);
//   final group = GroupControllers();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(Strings.register),
//         ),
//         body: getBody());
//   }

//   @override
//   void initState() {
//     super.initState();
//     groupControllers.add(group);
//   }

//   Widget getBody() {
//     return SingleChildScrollView(
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(
//           minHeight: 100.0, //viewportConstraints.maxHeight,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//               "",
//               style: CustomTextStyle.loginTitleStyle().copyWith(fontSize: 36),
//             ),
//             buildStartDate(),
//             buildDropDown(indexForDropDown, selectedValue, (value) {
//               setState(() {
//                 selectedValue = value;
//               });
//             }),
//             buildSettingForm(_formKey),
//             gapH12,
//             buildSaveButton(),
//             gapH12,
//             buildAddMoreButton(),
//             gapH12,
//             Form(
//               key: _moreFormKey,
//               child: Flexible(
//                 // height: 400,
//                 child: buildMoreProductListView(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

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

//   Widget buildStartDate() {
//     return DateTimePicker(
//       labelText: Strings.date,
//       selectedDate: _startDate,
//       selectedTime: _startTime,
//       onSelectedDate: (date) => setState(() => _startDate = date),
//       onSelectedTime: (time) => setState(() => _startTime = time),
//     );
//   }

//   Widget buildDropDown(int index, String? value,
//       [ValueChanged<String?>? onChanged]) {
//     return CustomDropdownButton2(
//       dropdownItems: items,
//       onChanged: onChanged,
//       hint: 'Select Item',
//       value: value,
//     );
//   }

//   Form buildSettingForm(Key key) {
//     return Form(
//       key: key,
//       child: Column(
//         children: <Widget>[
//           generateTextField(groupControllers[indexForDropDown].name,
//               Strings.name, TextInputAction.next),
//           generateTextField(groupControllers[indexForDropDown].price,
//               Strings.price, TextInputAction.next),
//           generateTextField(groupControllers[indexForDropDown].quantity,
//               Strings.quantity, TextInputAction.done),
//         ],
//       ),
//     );
//   }

//   AppButton buildSaveButton() {
//     return AppButton(
//       text: Strings.save,
//       onPress: () async {
//         if (!_formKey.currentState!.validate() &&
//             !_moreFormKey.currentState!.validate()) return;

//         final userID = ref.read(currentUserRepositoryProvider).value;
//         if (userID != null) {
//           final now = DateTime.now();
//           var product = Product(
//               name: 'Milk verka',
//               price: groupControllers[0].price.text.parseInt(),
//               type: selectedValue,
//               quantity: groupControllers[0].quantity.text.parseInt(),
//               date: TemporalDateTime(now),
//               userID: userID,
//               moreProducts: moreProductList);
//           print(product);
//           // ref.read(productRepositoryProvider).createProduct(product);
//         }
//       },
//     );
//   }

//   AppButton buildAddMoreButton() {
//     return AppButton(
//       text: Strings.addMore,
//       onPress: () {
//         final group = GroupControllers();

//         final priceField = generateTextField(
//             priceController, Strings.price, TextInputAction.next);
//         final quantityField = generateTextField(
//             quantityController, Strings.quantity, TextInputAction.done);
//         setState(() {
//           groupControllers.add(group);

//           priceFields.add(priceField);
//           quantityFields.add(quantityField);
//           moreProductList.add(MoreProduct());
//         });
//       },
//     );
//   }

//   ListView buildMoreProductListView() {
//     return ListView.builder(
//         padding: const EdgeInsets.all(8),
//         shrinkWrap: true,
//         primary: false,
//         itemCount: moreProductList.length,
//         itemBuilder: (BuildContext context, int index) {
//           int indexForList = index + 1;
//           MoreProduct ins = moreProductList[index];

//           return SizedBox(
//             // height: 50,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "",
//                   style:
//                       CustomTextStyle.loginTitleStyle().copyWith(fontSize: 36),
//                 ),
//                 buildDropDown(index, moreProductList[index].type, (value) {
//                   setState(() {
//                     moreProductList[index] = ins.copyWith(type: value);
//                   });
//                 }),
//                 // priceFields[index],
//                 // quantityFields[index],
//                 generateTextField(groupControllers[indexForList].name,
//                     Strings.name, TextInputAction.next, (value) {
//                   setState(() {
//                     moreProductList[index] =
//                         ins.copyWith(price: value.parseInt());
//                   });
//                 }),
//                 generateTextField(groupControllers[indexForList].price,
//                     Strings.price, TextInputAction.next, (value) {
//                   setState(() {
//                     moreProductList[index] =
//                         ins.copyWith(price: value.parseInt());
//                   });
//                 }),
//                 generateTextField(groupControllers[indexForList].quantity,
//                     Strings.quantity, TextInputAction.done, (value) {
//                   setState(() {
//                     moreProductList[index] =
//                         ins.copyWith(quantity: value.parseInt());
//                   });
//                 }),
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   void dispose() {
//     priceController.dispose();
//     quantityController.dispose();
//     for (final controller in groupControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }

// /// These [GroupControllers] are used for name, price, quantity as [TextEditingController].
// class GroupControllers {
//   TextEditingController name = TextEditingController();
//   TextEditingController price = TextEditingController();
//   TextEditingController quantity = TextEditingController();

//   void dispose() {
//     name.dispose();
//     price.dispose();
//     quantity.dispose();
//   }
// }
