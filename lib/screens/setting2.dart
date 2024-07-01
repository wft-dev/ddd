import 'package:daily_dairy_diary/utils/show_exception_alert_dialog.dart';
import 'package:flutter/material.dart';

class Setting2 extends StatefulWidget {
  const Setting2({super.key});

  @override
  Setting2State createState() => Setting2State();
}

class _GroupControllers {
  TextEditingController name = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController address = TextEditingController();
  void dispose() {
    name.dispose();
    tel.dispose();
    address.dispose();
  }
}

class Setting2State extends State<Setting2> {
  final List<_GroupControllers> _groupControllers = [];
  final List<TextField> _nameFields = [];
  final List<TextField> _telFields = [];
  final List<TextField> _addressFields = [];

  @override
  void dispose() {
    for (final controller in _groupControllers) {
      controller.dispose();
    }
    _okController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Dynamic Group Text Field2"),
          ),
          body: Column(
            children: [
              _addTile(),
              Expanded(child: _listView()),
              _okButton(context),
            ],
          )),
    );
  }

  Widget _addTile() {
    return ListTile(
      title: const Icon(Icons.add),
      onTap: () {
        final group = _GroupControllers();

        final nameField = _generateTextField(group.name, "name");
        final telField = _generateTextField(group.tel, "mobile");
        final addressField = _generateTextField(group.address, "address");

        setState(() {
          _groupControllers.add(group);
          _nameFields.add(nameField);
          _telFields.add(telField);
          _addressFields.add(addressField);
        });
      },
    );
  }

  TextField _generateTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: hint,
      ),
    );
  }

  Widget _listView() {
    final children = [
      for (var i = 0; i < _groupControllers.length; i++)
        Container(
          margin: const EdgeInsets.all(5),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: i.toString(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                _nameFields[i],
                _telFields[i],
                _addressFields[i],
              ],
            ),
          ),
        )
    ];
    return SingleChildScrollView(
      child: Column(
        children: children,
      ),
    );
  }

  final _okController = TextEditingController();
  Widget _okButton(BuildContext context) {
    final textField = TextField(
      controller: _okController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );

    final button = ElevatedButton(
      onPressed: () async {
        final index = int.parse(_okController.text);
        String text =
            "name: ${_groupControllers[index].name.text}\ntel: ${_groupControllers[index].tel.text}\naddress: ${_groupControllers[index].address.text}\n";
        // await showMessage(context, text, "Result");

        showExceptionAlertDialog(
          context: context,
          title: text,
          exception: "Result",
        );
      },
      child: const Text("OK"),
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 100,
          height: 50,
          child: textField,
        ),
        button,
      ],
    );
  }
}
