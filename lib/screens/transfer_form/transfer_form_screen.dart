import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const String _titluloAppBar = 'Criando Transferência';
const String _accNumFieldLabel = 'Numero da Conta';
const String _valueFieldLabel = 'Valor';
const String _formHint = '0000';

class TransferFormScreen extends StatefulWidget {
  final TextEditingController _accountNumController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  TransferFormScreen({super.key});

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen> {
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
              controller: widget._accountNumController,
              label: _accNumFieldLabel,
              hint: _formHint,
            ),
            Editor(
              controller: widget._valueController,
              icon: Icon(
                Icons.monetization_on,
                color: Colors.green.shade900,
              ),
              label: _valueFieldLabel,
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
    if (widget._accountNumController.text.compareTo('') == 0 ||
        widget._valueController.text.compareTo('') == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos'),
        ),
      );
    } else {
      final int accNum = int.parse(widget._accountNumController.text);
      final double trfVal = double.parse(widget._valueController.text);
      final transferCreated = Transfer(accountNumber: accNum, value: trfVal);
      Navigator.of(context).pop<Transfer>(transferCreated);
    }
  }
}
