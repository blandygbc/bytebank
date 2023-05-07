import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NameCubit extends Cubit<String> {
  NameCubit(super.initialState);
  void change(String name) => emit(name);
}

class NameContainer extends StatelessWidget {
  const NameContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Gabriel"),
      child: NameView(),
    );
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
        title: const Text('Mudar Nome'),
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
