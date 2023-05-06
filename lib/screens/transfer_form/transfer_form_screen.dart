import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transfer_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const String _titluloAppBar = 'Criando Transferência';
const String _valueFieldLabel = 'Valor';
const String _formHint = '0000';

class TransferFormScreen extends StatefulWidget {
  final Contact contact;
  const TransferFormScreen({super.key, required this.contact});

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen> {
  late final TextEditingController _valueEC;
  final TransferWebclient _webclient = TransferWebclient();
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
        title: const Text(_titluloAppBar),
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
      final transferCreated =
          Transfer(contact: widget.contact, value: tansferVal);
      showDialog(
        context: context,
        builder: (contextDialog) {
          return TransactionAuthDialog(
            onConfirm: (password) {
              _save(transferCreated, password, context);
            },
          );
        },
      );
    }
  }

  void _save(
      Transfer transferCreated, String password, BuildContext context) async {
    try {
      await _webclient.save(transferCreated, password);
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return const SuccessDialog(message: "Sucessful transfer!");
          },
        ).then((value) => Navigator.of(context).pop());
      }
    } on Exception catch (e) {
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(message: e.toString().substring(11));
          });
    }
  }
}
