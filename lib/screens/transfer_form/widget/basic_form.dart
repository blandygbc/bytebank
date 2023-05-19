import 'package:bytebank/screens/transfer_form/transfer_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../components/editor.dart';
import '../../../components/transaction_auth_dialog.dart';
import '../../../models/contact.dart';
import '../../../models/transfer.dart';

class BasicForm extends StatefulWidget {
  final Contact contact;
  const BasicForm({super.key, required this.contact});

  @override
  State<BasicForm> createState() => _BasicFormState();
}

class _BasicFormState extends State<BasicForm> {
  final String _titluloAppBar = 'Criando Transferência';
  final String _valueFieldLabel = 'Valor';
  final String _formHint = '0000';

  late final TextEditingController _valueEC;

  final String idGeneratedByForm = const Uuid().v4();

  @override
  void initState() {
    _valueEC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _valueEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titluloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
              child: Text(
                widget.contact.name,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
              child: Text(
                widget.contact.account.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Editor(
              controller: _valueEC,
              icon: Icon(
                Icons.monetization_on,
                color: Colors.green.shade900,
              ),
              label: _valueFieldLabel,
              hint: _formHint,
            ),
            Center(
              child: SizedBox(
                height: 42,
                width: 250,
                child: ElevatedButton(
                  onPressed: () => _createTransfer(context),
                  child: const Text('Transferir'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    if (_valueEC.text.compareTo('') == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O valor deve ser preenchido!'),
        ),
      );
    } else {
      final double tansferVal = double.parse(_valueEC.text);
      final transferCreated = Transfer(
        id: idGeneratedByForm,
        contact: widget.contact,
        value: tansferVal,
      );
      authenticateTransfer(context, transferCreated);
    }
  }

  void authenticateTransfer(BuildContext context, Transfer transferCreated) {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return TransactionAuthDialog(
          onConfirm: (password) {
            BlocProvider.of<TransferFormCubit>(context)
                .save(transferCreated, password, context);
          },
        );
      },
    );
  }
}
