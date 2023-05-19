// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bytebank/components/container.dart';
import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:bytebank/screens/dashboard/widgets/feature_item.dart';
import 'package:bytebank/screens/name/name.dart';
import 'package:bytebank/screens/transfer_list/transfer_feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/name.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameCubit("Gabriel"),
      child: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.read<NameCubit>().state;
    return Scaffold(
      appBar: AppBar(
          title: BlocBuilder<NameCubit, String>(
        builder: (context, state) => Text('Welcome $name'),
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {
                      push(context, const ContactsListContainer());
                    },
                    child: const FeatureItem(
                      icon: Icons.people,
                      name: 'Contacts',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      push(context, const TransferFeedContainer());
                    },
                    child: const FeatureItem(
                      icon: Icons.description,
                      name: 'Transaction Feed',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _push(
                          context,
                          BlocProvider.value(
                            value: BlocProvider.of<NameCubit>(context),
                            child: const NameContainer(),
                          ));
                    },
                    child: const FeatureItem(
                      icon: Icons.person_outline,
                      name: 'Change Name',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _push(BuildContext blocContext, Widget page) {
    Navigator.of(blocContext).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }
}
