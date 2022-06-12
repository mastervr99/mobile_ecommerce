abstract class UserRepository {
  init();

  registerUser(Map newUserInfos);

  retrieveUser(Map userInfos);

  close();
}
