import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

abstract class UserDao {

  void saveUserInfo(UserVO user);
  void deleteUser();
  UserVO? getUserInfo() ;
  Stream<void> getUserEventStream();
  Stream<UserVO?> getUserStream();
}
