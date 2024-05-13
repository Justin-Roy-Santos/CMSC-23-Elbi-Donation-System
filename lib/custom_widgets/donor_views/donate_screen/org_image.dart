import 'package:flutter/material.dart';
// data model
import 'package:elbi_donation_system/data_models/organization.dart';

class OrgImage extends StatelessWidget {
  const OrgImage({required this.org, super.key});

  // property
  final Organization org;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: org.id!,
      child: Image.asset(
        org.orgImagePath,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
