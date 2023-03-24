// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bytebank/screens/dashboard/widgets/feature_item.dart';
import 'package:bytebank/screens/transfer_form/transfer_form_screen.dart';
import 'package:flutter/material.dart';

import 'package:bytebank/screens/contacts/contacts_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/bytebank_logo.png'),
          ),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ContactsList(),
                    ));
                  },
                  child: const FeatureItem(
                    icon: Icons.people,
                    name: 'Contacts',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TransferFormScreen(),
                    ));
                  },
                  child: const FeatureItem(
                    icon: Icons.description,
                    name: 'Transaction Feed',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
