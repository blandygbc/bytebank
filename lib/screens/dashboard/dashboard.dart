import 'package:bytebank/screens/contacts/contacts_list.dart';
import 'package:flutter/material.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.green.shade900,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ContactsList(),
                  ));
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 100,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 28,
                        ),
                        Text(
                          'Contacts',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
