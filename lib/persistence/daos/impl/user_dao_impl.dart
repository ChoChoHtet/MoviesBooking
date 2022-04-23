import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/persistence/daos/user_dao.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

class UserDaoImpl extends UserDao{
  UserDaoImpl._internal();
  static final UserDaoImpl _singleton = UserDaoImpl._internal();

  factory UserDaoImpl() {
    return _singleton;
  }

  @override
  void saveUserInfo(UserVO user) async {
    //debugPrint("User Dao: ${user.toString()}");
    await getUserBox().put("user", user);
  }

  @override
  void deleteUser(){
    Hive.box<UserVO>(BOX_NAMES_USER_VO).clear();
  }

  @override
  UserVO? getUserInfo()  {
    return getUserBox().get("user");
  }

  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAMES_USER_VO);
  }

  @override
  Stream<void> getUserEventStream(){
    return getUserBox().watch();
  }

  @override
  Stream<UserVO?> getUserStream(){
    return Stream.value(getUserInfo());
  }
}
