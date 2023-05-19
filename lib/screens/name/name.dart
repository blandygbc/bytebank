import 'package:bytebank/components/container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../models/name.dart';

class NameContainer extends BlocContainer {
  const NameContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return NameView();
  }
}

class NameView extends StatelessWidget {
  final _nameEC = TextEditingController();

  NameView({super.key});

  @override
  Widget build(BuildContext context) {
    _nameEC.text = context.read<NameCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Name'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameEC,
            decoration: const InputDecoration(
              labelText: "Desired Name",
            ),
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              child: const Text('Change'),
              onPressed: () {
                final name = _nameEC.text;
                context.read<NameCubit>().change(name);
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
