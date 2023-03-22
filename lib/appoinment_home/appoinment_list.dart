//import 'dart:ffi';


import 'package:factory_management_ctse/appoinment_home/edit_apoinment_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../data/models/apponment_model.dart';
import '../data/remote_data_source/appoinment_helper.dart';
import '../services/auth.dart';

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

class AppoinmentList extends StatefulWidget {
  const AppoinmentList({Key? key}) : super(key: key);

  @override
  State<AppoinmentList> createState() => _AppoinmentListState();
}

class _AppoinmentListState extends State<AppoinmentList> {
  final TextEditingController _fullnamecontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
  final AuthService service = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullnamecontroller.dispose();
    _agecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Appoinment List"),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                StreamBuilder<List<AppoinmentModel>>(
                    stream: AppoinmentHelper.read(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Some error occured"),
                        );
                      }
                      if (snapshot.hasData) {
                        final docterdata = snapshot.data;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: docterdata!.length,
                            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                            itemBuilder: (context, Index) {
                              final singledoctor = docterdata[Index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle),
                                    ),
                                    title: Text("${singledoctor.doctorName}"),
                                    subtitle: Text("${singledoctor.hospitalName}"),
                                    trailing: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditAppoinmentnfo(
                                                            appoinment: AppoinmentModel(
                                                                doctorName:
                                                                    singledoctor
                                                                        .doctorName,
                                                                hospitalName:
                                                                    singledoctor
                                                                        .hospitalName,
                                                                date:
                                                                    singledoctor
                                                                        .date,
                                                                reson:
                                                                    singledoctor
                                                                        .reson,
                                                                id: singledoctor
                                                                    .id),
                                                          )));
                                            },
                                            child: const Icon(Icons.edit)),
                                        // SizedBox(
                                        //   height: 0.5,
                                        // ),
                                        InkWell(
                                          onTap: () {
                                            //call your onpressed function here
                                            if (kDebugMode) {
                                              print('Button Pressed');
                                            }
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text("Delete Confirm"),
                                                    content: const Text(
                                                        "Are You sure You want to delete"),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            AppoinmentHelper.delete(
                                                                    singledoctor)
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: const Text("Delete"))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Icon(Icons.delete),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future _create() async {
  //   final doctorCollection = FirebaseFirestore.instance.collection("doctors");
  //   final docRef = doctorCollection.doc();
  //   await docRef.set({
  //     "fullname": _fullnamecontroller.text,
  //     "age": _agecontroller.text,
  //   });
  // }
}
