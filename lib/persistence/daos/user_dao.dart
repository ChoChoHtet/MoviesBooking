import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

class UserDao {
  UserDao._internal();
  static final UserDao _singleton = UserDao._internal();

  factory UserDao() {
    return _singleton;
  }

  void saveUserInfo(UserVO user) async {
    debugPrint("User Dao: ${user.toString()}");
    await getUserBox().put("user", user);
  }

  UserVO? getUserInfo()  {
    return getUserBox().get("user");
  }

  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAMES_USER_VO);
  }

  Stream<void> getUserEventStream(){
    return getUserBox().watch();
  }

  Stream<UserVO?> getUserStream(){
    return Stream.value(getUserInfo());
  }
}
