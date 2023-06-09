import 'package:factory_management_ctse/data/models/drugs_model.dart';
import 'package:factory_management_ctse/data/remote_data_source/drug_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/auth.dart';
import '../shared/constants.dart';
import 'drugs_list.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  // ignore: deprecated_member_use
  primary: Colors.white,
  minimumSize: const Size(88, 44),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  //backgroundColor: Color.fromARGB(255, 3, 33, 57),
);

class AddDrugs extends StatefulWidget {
  const AddDrugs({Key? key}) : super(key: key);

  @override
  State<AddDrugs> createState() => _AddDrugsState();
}

class _AddDrugsState extends State<AddDrugs> {
  TextEditingController _drCodecontroller = TextEditingController();
  final TextEditingController _drNamecontroller = TextEditingController();
  final TextEditingController _unitPriceontroller = TextEditingController();
  final TextEditingController _drCategorycontroller = TextEditingController();
  final TextEditingController _drStatuscontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? drugcategory = 'Select a Category';

  final List<String> drugcategories = [
    'Select a Category',
    'Blood Pressure',
    'Blood Cholesterol',
    'Blood Glucose',
    'Antibiotics',
    'Painkillers',
    'Other Drugs',
  ];
   String? selectedValue = 'Select a Category';

  final List<String> drugStatus = [
    'Select a Status',
    'Available',
    'Unavailable'
  ];
   String? selectedValueStatus = 'Select a Status';

  final AuthService service = AuthService();

  @override
  void dispose() {
    _drCodecontroller.dispose();
    _drNamecontroller.dispose();
    _unitPriceontroller.dispose();
    _drCategorycontroller.dispose();
    _drStatuscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New Drug Details"),
          backgroundColor: const Color.fromARGB(255, 17, 90, 150),
          elevation: 0.0,
          actions: <Widget>[
            TextButton(
              style: flatButtonStyle,
              onPressed: () async {
                if (kDebugMode) {
                  print('sign out');
                }
                service.signOut();
              },
              child: const Icon(Icons.person),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 300.0,
                  decoration: const BoxDecoration(
                      color: Colors.yellow,
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/onlinedoctorbro.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(250),
                        bottomRight: Radius.circular(0),
                      )),
                ),
                const SizedBox(height: 20.0),
                const Text("Welcome",
                    style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 10.0),
                const Text("Add Drug",
                    style: TextStyle(fontSize: 16.0, color: Colors.black)),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      child: const Text(
                        "View all",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DrugsList()));
                      }),
                ),
                // const Schedule(),
                const SizedBox(height: 30.0),
                // const Image(image: AssetImage('graphics/background.png')),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Drug Name Cant be empty' : null,
                  controller: _drNamecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Drug Name",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Drug Code Cant be empty' : null,
                  controller: _drCodecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Drug Code",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Unit Price Cant be empty' : null,
                  controller: _unitPriceontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Unit Price",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // TextFormField(
                //   validator: (value) =>
                //       value!.isEmpty ? 'Drug Category Cant be empty' : null,
                //   controller: _drCategorycontroller,
                //   keyboardType: TextInputType.text,
                //   textInputAction: TextInputAction.next,
                //   decoration: const InputDecoration(
                //     hintText: "Drug Category",
                //     prefixIcon: Padding(
                //       padding: EdgeInsets.all(defaultPadding),
                //       child: Icon(Icons.person),
                //     ),
                //   ),
                // ),
                DropdownButtonFormField(
                  validator: (value) => value!.toString() == 'Select a Category'
                      ? 'category Cant be empty'
                      : null,
                  decoration: textInputDecoration,
                  value: selectedValue,
                  items: drugcategories.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // print(value);
                    selectedValue = value as String?;
                    // setState(() => doctorcategory = value as String?);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  validator: (value) => value!.toString() == 'Select a Status'
                      ? 'category Cant be empty'
                      : null,
                  decoration: textInputDecoration,
                  value: selectedValueStatus,
                  items: drugStatus.map((c) {
                    return DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // print(value);
                    selectedValueStatus = value as String?;
                    // setState(() => doctorcategory = value as String?);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (kDebugMode) {
                        print("Create Data");
                      }
                      //_create();
                      DrugHelper.create(DrugsModel(
                          drCode: _drCodecontroller.text,
                          drName: _drNamecontroller.text,
                          unitPrice: _unitPriceontroller.text,
                          drCategory: selectedValue,
                          drStatus: selectedValueStatus));

                      final snackBar = SnackBar(
                        content: const Text('Drug Record Added Successfully'),
                        backgroundColor:
                            const Color.fromARGB(255, 17, 90, 150),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DrugsList()));
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.yellow),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Add Drug",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
