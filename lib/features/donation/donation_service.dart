import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ala/models/donation/donation_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationService {
  DonationService._init();
  static final DonationService _instance = DonationService._init();
  static DonationService get instance => _instance;

  Future<List<Map<String, dynamic>>> getCollection() async {
    List<DocumentSnapshot> templist;
    List<Map<String, dynamic>> list;
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.uid);
    QuerySnapshot collectionSnapshot = await collectionRef.get();

    templist = collectionSnapshot.docs;

    list = templist.map((e) {
      return e.data() as Map<String, dynamic>;
    }).toList();
    return list;
  }

  Future<List<DonationInfo>> getDonationInfo() async {
    final list = await getCollection();

    final donationList = list.map((e) => DonationInfo.fromMap(e)).toList();

    return donationList;
  }
}
