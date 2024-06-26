import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_quest/app/data/user/model/user_model.dart';

class UserDataSource {
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<UserModel?> getUser({required String uid}) async {
    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> updateUser({required UserModel user}) async {
    try {
      await userCollection.doc(user.uid).set(user.toJson());
    } catch (e) {
      throw Exception('update Failed');
    }
  }

  Future<void> deleteUser({required String uid}) async {
    try {
      await userCollection.doc(uid).delete();
    } catch (e) {
      throw Exception('delete Failed');
    }
  }

  Future<QuerySnapshot> checkNickname({required String nickname}) async {
    QuerySnapshot snapshot =
        await userCollection.where('nickname', isEqualTo: nickname).get();
    return snapshot;
  }
}
