import 'package:flutter/material.dart';

// C U R R E N C Y S Y M B O L
const String currency = '৳';

// B U S   T Y P E
abstract final class BusType{
  static const String acBusiness = 'AC-Business';
  static const String acEconomy = 'AC-Economy';
  static const String nonAc = 'non-AC';
}

// B U S   T Y P E   L I S T
const busTypeList = [BusType.acBusiness, BusType.acEconomy, BusType.nonAc];

// R O U T E   T Y P E   L I S T
const routeTypeList = [
  'Dhaka', 'Chittagong', 'Khulna', 'Rajshahi', 'Sylhet', 'Barisal', 'Rangpur',
  'Comilla', 'Narayanganj', 'Gazipur','Mymensingh', 'Dinajpur', 'Bogra', 'Jessore',
  'Saidpur', 'Brahmanbaria', 'Pabna', 'Tangail', 'Kushtia', 'Faridpur', 'Cox\'s Bazar',
  'Narsingdi', 'Feni', 'Chandpur', 'Lakshmipur', 'Noakhali', 'Habiganj', 'Sunamganj',
  'Netrokona','Moulvibazar', 'Sherpur', 'Jamalpur', 'Thakurgaon', 'Panchagarh',
  'Nilphamari', 'Lalmonirhat', 'Gaibandha', 'Kurigram', 'Natore', 'Sirajganj',
  'Naogaon', 'Joypurhat', 'Chapainawabganj', 'Satkhira', 'Meherpur', 'Jhenaidah',
  'Magura', 'Narail', 'Bagerhat', 'Pirojpur', 'Jhalokati', 'Patuakhali', 'Barguna',
  'Bhola',
];

// B U S   S E A T   L E T T  E R   L I S T
const letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

