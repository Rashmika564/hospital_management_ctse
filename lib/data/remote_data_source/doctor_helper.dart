import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:factory_management_ctse/data/models/doctor_model.dart';

class DoctorHelper {
  static Stream<List<DoctorModel>> read() {
    final doctorCollection = FirebaseFirestore.instance.collection("doctors");
    return doctorCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => DoctorModel.fromSnapshot(e)).toList());
  }

  static Future create(DoctorModel doctor) async {
    final doctorCollection = FirebaseFirestore.instance.collection("doctors");

    final did = doctorCollection.doc().id;
    final docRef = doctorCollection.doc(did);

    final newDoctor = DoctorModel(
            id: did,
            fullname: doctor.fullname,
            age: doctor.age,
            doctorcategory: doctor.doctorcategory,
            mobilenumber: doctor.mobilenumber,
            livingaddress: doctor.livingaddress,
            noofassignednurses: doctor.noofassignednurses)
        .toJson();

    try {
      await docRef.set(newDoctor);
    } catch (e) {
      print("some error occured");
    }
  }

  static Future update(DoctorModel doctor) async {
    final doctorCollection = FirebaseFirestore.instance.collection("doctors");

    final docRef = doctorCollection.doc(doctor.id);

    final updateDoctorRec = DoctorModel(
            id: doctor.id,
            fullname: doctor.fullname,
            age: doctor.age,
            doctorcategory: doctor.doctorcategory,
            mobilenumber: doctor.mobilenumber,
            livingaddress: doctor.livingaddress,
            noofassignednurses: doctor.noofassignednurses)
        .toJson();

    try {
      await docRef.update(updateDoctorRec);
    } catch (e) {
      print("some error occured");
    }
  }

  static Future delete(DoctorModel doctor) async {
    final doctorCollection = FirebaseFirestore.instance.collection("doctors");
    final docRef = doctorCollection.doc(doctor.id).delete();
  }
}
