import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ala/core/constants/collection_constant.dart';
import 'package:final_project_ala/models/project/project_model.dart';

class ProjectModelList {
  ProjectModelList._init();
  static final ProjectModelList _instance = ProjectModelList._init();
  static ProjectModelList get instance => _instance;

  Future<List<Map<String, dynamic>>> getCollection() async {
    List<DocumentSnapshot> templist;
    List<Map<String, dynamic>> list;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(CollectionConstant.projects);
    QuerySnapshot collectionSnapshot = await collectionRef.get();

    templist = collectionSnapshot.docs;

    list = templist.map((e) {
      return e.data() as Map<String, dynamic>;
    }).toList();
    return list;
  }

  Future<List<ProjectInfo>> getProjectInfo() async {
    final list = await getCollection();

    final projectList = list.map((e) => ProjectInfo.fromMap(e)).toList();

    return projectList;
  }
}
