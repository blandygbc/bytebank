import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TransferForm(),
    );
  }
}

class TransferForm extends StatelessWidget {
  final TextEditingController _accountNumController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  TransferForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
        children: [
          Editor(
            controller: _valueController,
            label: 'Numero da Conta',
            hint: '0000',
          ),
          Editor(
            controller: _valueController,
            icon: const Icon(Icons.monetization_on),
            label: 'Valor',
            hint: '0000',
          ),
          ElevatedButton(
            onPressed: () => _createTransfer(context),
            child: const Text('Transferir'),
          )
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    if (_accountNumController.text.compareTo('') == 0 ||
        _valueController.text.compareTo('') == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos'),
        ),
      );
    } else {
      final int accNum = int.parse(_accountNumController.text);
      final double trfVal = double.parse(_valueController.text);
      var transferCreated = Transfer(accountNumber: accNum, value: trfVal);
    }
  }
}

class Editor extends StatelessWidget {
  final Icon? icon;
  final String label;
  final String hint;
  final TextEditingController controller;

  const Editor({
    super.key,
    required this.controller,
    this.icon,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
          icon: icon,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransferList extends StatelessWidget {
  const TransferList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Adicionar uma transferência',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          TransferItem(
            Transfer(
              value: 100.00,
              accountNumber: 1000,
            ),
          ),
          TransferItem(
            Transfer(
              value: 100.00,
              accountNumber: 1000,
            ),
          ),
          TransferItem(
            Transfer(
              value: 300.00,
              accountNumber: 1000,
            ),
          ),
        ],
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;
  const TransferItem(this._transfer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int accountNumber;
  Transfer({
    required this.value,
    required this.accountNumber,
  });

  @override
  String toString() => 'Transfer(value: $value, accountNumber: $accountNumber)';
}
