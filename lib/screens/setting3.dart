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

// class Setting3 extends ConsumerStatefulWidget {
//   const Setting3({super.key});
//   @override
//   ConsumerState<Setting3> createState() => Setting3State();
// }

// class Setting3State extends ConsumerState<Setting3> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _moreFormKey = GlobalKey<FormState>();

//   final TextEditingController priceController = TextEditingController(text: "");
//   final TextEditingController quantityController =
//       TextEditingController(text: "");
//   final TextEditingController typeController = TextEditingController(text: "");
//   late DateTime _startDate = DateTime.now();
//   late TimeOfDay _startTime = TimeOfDay.now();
//   late DateTime _endDate;
//   late TimeOfDay _endTime;
//   String? selectedValue;

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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(Strings.register),
//         ),
//         body: getBody());
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
//             buildDropDown(),
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

//   AppTextFormField generateTextField(
//       TextEditingController controller, String label) {
//     return AppTextFormField(
//       controller: controller,
//       label: label,
//       validator: (value) => Validations.validateString(value, Strings.price),
//       textInputAction: TextInputAction.next,
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

//   Widget buildDropDown() {
//     return CustomDropdownButton2(
//       dropdownItems: items,
//       onChanged: (String? value) {
//         setState(() {
//           selectedValue = value;
//         });
//       },
//       hint: 'Select Item',
//       value: selectedValue,
//     );
//   }

//   Form buildSettingForm(Key key) {
//     return Form(
//       key: key,
//       child: Column(
//         children: <Widget>[
//           AppTextFormField(
//             controller: priceController,
//             label: Strings.price,
//             validator: (value) =>
//                 Validations.validateString(value, Strings.price),
//             textInputAction: TextInputAction.next,
//           ),
//           AppTextFormField(
//             controller: quantityController,
//             label: Strings.quantity,
//             validator: (value) =>
//                 Validations.validateString(value, Strings.quantity),
//             textInputAction: TextInputAction.done,
//           ),
//         ],
//       ),
//     );
//   }

//   AppButton buildSaveButton() {
//     return AppButton(
//       text: Strings.save,
//       onPress: () async {
//         if (!_formKey.currentState!.validate()) return;
//         final userID = ref.read(currentUserRepositoryProvider).value;
//         if (userID != null) {
//           final now = DateTime.now();
//           var product = Product(
//               name: 'Milk verka',
//               price: priceController.text.parseInt(),
//               type: selectedValue,
//               quantity: quantityController.text.parseInt(),
//               date: TemporalDateTime(now),
//               userID: userID);
//           ref.read(productRepositoryProvider).createProduct(product);
//         }
//       },
//     );
//   }

//   AppButton buildAddMoreButton() {
//     return AppButton(
//       text: Strings.addMore,
//       onPress: () {
//         setState(() => moreProductList.add(MoreProduct()));
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
//                 // buildDropDown(),
//                 buildSettingForm(_moreFormKey),
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   void dispose() {
//     priceController.dispose();
//     quantityController.dispose();
//     super.dispose();
//   }
// }
