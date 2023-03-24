import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const String _titluloAppBar = 'Criando Transferência';
const String _nameFieldLabel = 'Nome do Contato';
const String _accNumFieldLabel = 'Numero da Conta';
const String _valueFieldLabel = 'Valor';
const String _formHint = '0000';

class TransferFormScreen extends StatefulWidget {
  const TransferFormScreen({super.key});

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen> {
  late final TextEditingController _nameEC;
  late final TextEditingController _accountNumEC;
  late final TextEditingController _valueEC;
  @override
  void initState() {
    _nameEC = TextEditingController();
    _accountNumEC = TextEditingController();
    _valueEC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _accountNumEC.dispose();
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
          children: [
            Editor(
              controller: _valueEC,
              icon: Icon(
                Icons.monetization_on,
                color: Colors.green.shade900,
              ),
              label: _valueFieldLabel,
              hint: _formHint,
            ),
            Editor(
              controller: _nameEC,
              label: _nameFieldLabel,
              hint: _formHint,
            ),
            Editor(
              controller: _accountNumEC,
              label: _accNumFieldLabel,
              hint: _formHint,
            ),
            ElevatedButton(
              onPressed: () => _createTransfer(context),
              child: const Text('Transferir'),
            )
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    if (_accountNumEC.text.compareTo('') == 0 ||
        _valueEC.text.compareTo('') == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos'),
        ),
      );
    } else {
      final name = _nameEC.text;
      final int accNum = int.parse(_accountNumEC.text);
      final double trfVal = double.parse(_valueEC.text);
      final contact = Contact(id: 0, name: name, account: accNum);
      final transferCreated = Transfer(contact: contact, value: trfVal);
      Navigator.of(context).pop<Transfer>(transferCreated);
    }
  }
}
