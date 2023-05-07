import 'dart:async';

import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/exceptions/http_exception.dart';
import 'package:bytebank/http/webclients/transfer_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
  final String idGeneratedByForm = const Uuid().v4();
  bool sending = false;
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
    debugPrint('Generated transfer id $idGeneratedByForm');
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titluloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: sending,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Progress(message: "Sending..."),
              ),
            ),
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
            _save(transferCreated, password, context);
          },
        );
      },
    );
  }

  void _save(
      Transfer transferCreated, String password, BuildContext context) async {
    setState(() {
      sending = true;
    });
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
    } on TimeoutException catch (_) {
      _showFailureMessage(context, "Timeout submiting transfer");
    } on HttpException catch (e) {
      _showFailureMessage(context, e.message);
    } on Exception catch (_) {
      _showFailureMessage(context, "Unknow error");
    } finally {
      setState(() {
        sending = false;
      });
    }
  }

  void _showFailureMessage(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message: message);
        });
  }
}
