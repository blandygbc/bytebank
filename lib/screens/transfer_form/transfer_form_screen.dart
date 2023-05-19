import 'dart:async';

import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/http/exceptions/http_exception.dart';
import 'package:bytebank/http/webclients/transfer_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/error_screen.dart';
import '../../components/progress_screen.dart';
import 'widget/basic_form.dart';

@immutable
abstract class TransferFormState {}

@immutable
class SendingTransferFormState extends TransferFormState {}

@immutable
class InitTransferFormState extends TransferFormState {}

@immutable
class SentTransferFormState extends TransferFormState {}

@immutable
class ErrorTransferFormState extends TransferFormState {
  final String _errorMessage;

  ErrorTransferFormState(this._errorMessage);
}

class TransferFormCubit extends Cubit<TransferFormState> {
  final TransferWebclient _webclient = TransferWebclient();

  TransferFormCubit() : super(InitTransferFormState());

  void save(
    Transfer transferCreated,
    String password,
    BuildContext context,
  ) async {
    emit(SendingTransferFormState());
    try {
      await _webclient.save(transferCreated, password);
      emit(SentTransferFormState());
    } on TimeoutException catch (_) {
      emit(ErrorTransferFormState("Timeout submiting transfer"));
    } on HttpException catch (e) {
      emit(ErrorTransferFormState(e.message));
    } on Exception catch (_) {
      emit(ErrorTransferFormState("Unknow error"));
    }
  }
}

class TransferFormContainer extends BlocContainer {
  final Contact contact;

  const TransferFormContainer({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransferFormCubit>(
      create: (context) => TransferFormCubit(),
      child: BlocListener<TransferFormCubit, TransferFormState>(
        listener: (context, state) {
          if (state is SentTransferFormState) {
            Navigator.pop(context);
          }
        },
        child: TransferFormScreen(contact: contact),
      ),
    );
  }
}

class TransferFormScreen extends StatelessWidget {
  final Contact contact;
  const TransferFormScreen({super.key, required this.contact});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferFormCubit, TransferFormState>(
      builder: (context, state) {
        if (state is InitTransferFormState) {
          return BasicForm(contact: contact);
        }
        if (state is SendingTransferFormState ||
            state is SentTransferFormState) {
          return const ProgressScreen();
        }
        if (state is ErrorTransferFormState) {
          return ErrorScreen(state._errorMessage);
        }
        return const ErrorScreen("Unknow Error!");
      },
    );
  }
}
