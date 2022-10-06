import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ala/core/constants/collection_constant.dart';
import 'package:final_project_ala/models/completed-project/c_project_model.dart';

class CProjectModelList {
  CProjectModelList._init();
  static final CProjectModelList _instance = CProjectModelList._init();
  static CProjectModelList get instance => _instance;

  Future<List<Map<String, dynamic>>> getCollection() async {
    List<DocumentSnapshot> templist;
    List<Map<String, dynamic>> list;
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection(CollectionConstant.completedProject);
    QuerySnapshot collectionSnapshot = await collectionRef.get();

    templist = collectionSnapshot.docs;

    list = templist.map((e) {
      return e.data() as Map<String, dynamic>;
    }).toList();
    return list;
  }

  Future<List<CProjectInfo>> getCProjectInfo() async {
    final list = await getCollection();

    final cProjectList = list.map((e) => CProjectInfo.fromMap(e)).toList();

    return cProjectList;
  }
}
