import 'package:barber/Constants/colors.dart';
import 'package:flutter/material.dart';

const TextStyle kGreyText = TextStyle(color: kGreyColor);
const TextStyle kBoldText = TextStyle(fontWeight: FontWeight.bold);
const TextStyle kH1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 26);
const TextStyle kH2 = TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
const TextStyle kH3 = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
const TextStyle kUnderlineText =
    TextStyle(decoration: TextDecoration.underline);
const TextStyle kWhiteText = TextStyle(color: kWhiteColor);
const TextStyle kBlackText = TextStyle(color: kBlackColor);

Widget pendingText =
    const Text('Pending', style: TextStyle(color: Colors.amber));
Widget disputeText =
    const Text('Dispute', style: TextStyle(color: kErrorColor));
Widget rentedText = const Text('Rented', style: TextStyle(color: kMainColor));
Widget doneText = const Text('Done', style: TextStyle(color: Colors.green));
Widget inProgressText =
    Text('Inprogress', style: TextStyle(color: Colors.amber[900]));
