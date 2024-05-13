import 'package:flutter/material.dart';
// data model
import 'package:elbi_donation_system/data_models/organization.dart';
// custom widgets
import 'package:elbi_donation_system/custom_widgets/donor_views/donate_screen/org_detail.dart';

class OrgDetails extends StatelessWidget {
  const OrgDetails({required this.org, super.key});

  // property
  final Organization org;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Org details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Org name
              Text(
                org.organizationName,
                textAlign: TextAlign.start,
                softWrap: true,
                // overflow: TextOverflow
                //     .ellipsis, // for handling overflow for very long texts
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // addresses
              ...org.addresses.map(
                (address) => OrgDetail(
                  detail: address,
                  icon: Icons.location_on_outlined,
                ),
              ),
              // Name of user (org representative) that registered the org in the app
              OrgDetail(
                detail: org.name,
                icon: Icons.person,
              ),
              // contact number of the representative of the org
              OrgDetail(
                detail: org.contactNumber,
                icon: Icons.phone,
              ), 
            ],
          ),
        ],
      ),
    );
  }
}
