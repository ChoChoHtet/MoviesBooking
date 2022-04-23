import 'package:movies_booking/data/vos/user_vo.dart';
import 'package:movies_booking/persistence/daos/user_dao.dart';

import '../mock_data/mock_data.dart';

class UserDaoImplMock extends UserDao{
  Map<String,UserVO> mockUser ={};
  @override
  void deleteUser() {
    mockUser.clear();
  }

  @override
  Stream<void> getUserEventStream() {
    return Stream<void>.value(null);
  }

  @override
  UserVO? getUserInfo() {
    return getMockUser();
  }

  @override
  Stream<UserVO?> getUserStream() {
   return Stream.value(getMockUser());
  }

  @override
  void saveUserInfo(UserVO user) {
    mockUser["user"] = user;
  }
  
}