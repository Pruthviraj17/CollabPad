class User {
  constructor(userModel, id) {
    this.userModel = userModel;
    this.id = id;
  }
}

class UserModel {
  constructor(username, email, image) {
    this.username = username;
    this.email = email;
    this.image = image;
  }
}

module.exports = {
  User,
  UserModel,
};
