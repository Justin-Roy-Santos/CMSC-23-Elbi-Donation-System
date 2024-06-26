import 'package:uuid/uuid.dart';

// utility object that generates unique id
const uuid = Uuid();
class Organization {
  // constructor
  Organization({
    this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.addresses,
    required this.contactNumber,
    required this.organizationName,
    required this.proofsOfLegitimacy,
    required this.orgImagePath,
  }) {
    // if the value of id is null, then the app will auto fill the id field
    id = id ?? uuid.v4();
  }

  // properties
  String? id;
  final String name;
  final String username;
  final String password;
  final List<String> addresses;
  final String contactNumber;
  final String organizationName;
  // not sure sa data type or pag handle ng image in general
  // sa ngayon paths to those images in the assets folder muna i-store nitong class
  final List<String> proofsOfLegitimacy;
  final String orgImagePath;
}