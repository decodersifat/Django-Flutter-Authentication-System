class UserData {
  final String username;
  final String email;
  final String password;

  UserData({
    required this.username,
    required this.email,
    required this.password,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}



class AuthData {
  final String email;
  final String password;
  AuthData({required this.email, required this.password});

  Map<String, Map<String,dynamic>> toJson(){
    return {
      'user':{
        'email':email,
        'password':password
      }
    };
  }
}




class ProfileData {
  final String fname;
  final String lname;
  final String gender;
  final int age;

  ProfileData({
    required this.fname,
    required this.lname,
    required this.gender,
    required this.age,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      fname: json['fname'],
      lname: json['lname'],
      gender: json['gender'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': fname,
      'lname': lname,
      'gender': gender,
      'age': age,
    };
  }
}

class UserModel {
  final UserData userData;
  final ProfileData profileData;

  UserModel({
    required this.userData,
    required this.profileData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userData: UserData.fromJson(json['user']),
      profileData: ProfileData.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': userData.toJson(),
      'profile': profileData.toJson(),
    };
  }
}
