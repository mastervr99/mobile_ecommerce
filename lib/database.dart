class Database {
  var database = [];
  saveData(String email, String password) {
    database = [email, password];
  }

  retrieveData(String email, String password) {
    return database;
  }
}
