class UserModel {
  String? id;
  String fullName;
  String number;
  String email;
  String address;

  UserModel({
    this.id,
    required this.fullName,
    required this.number,
    required this.email,
    required this.address,});

  // Method to convert UserModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'number': number,
      'email': email,
      'address': address,
    };
  }
  // Factory constructor to create a UserModel from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullName: map['fullName'],
      number: map['number'],email: map['email'],
      address: map['address'],
    );
  }
}