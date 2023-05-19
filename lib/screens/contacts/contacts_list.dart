import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/contacts_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form/contact_form.dart';
import 'package:bytebank/screens/contacts/widgets/contact_item.dart';
import 'package:bytebank/screens/transfer_form/transfer_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class ContactsListState {
  const ContactsListState();
}

@immutable
class LoadingContactsListState extends ContactsListState {}

@immutable
class InitialContactsListState extends ContactsListState {}

@immutable
class LoadedContactsListState extends ContactsListState {
  final List<Contact> _contacts;

  const LoadedContactsListState(this._contacts);
}

@immutable
class ErrorContactsListState extends ContactsListState {}

class ContactsListCubit extends Cubit<ContactsListState> {
  ContactsListCubit() : super(InitialContactsListState());

  void reload(ContactsDao dao) async {
    emit(LoadingContactsListState());
    dao.findAll().then(
          (contacts) => emit(
            LoadedContactsListState(contacts),
          ),
        );
  }
}

class ContactsListContainer extends BlocContainer {
  const ContactsListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final contactsDao = ContactsDao();
    return BlocProvider<ContactsListCubit>(
      create: (context) {
        final cubit = ContactsListCubit();
        cubit.reload(contactsDao);
        return cubit;
      },
      child: ContactsListScreen(dao: contactsDao),
    );
  }
}

class ContactsListScreen extends StatelessWidget {
  final ContactsDao dao;

  const ContactsListScreen({super.key, required this.dao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      floatingActionButton: buildAddContactButton(context),
      body: BlocBuilder<ContactsListCubit, ContactsListState>(
          builder: (context, state) {
        if (state is InitialContactsListState ||
            state is LoadingContactsListState) {
          return const Progress();
        }
        if (state is LoadedContactsListState) {
          final contacts = state._contacts;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return GestureDetector(
                onTap: () {
                  push(context, TransferFormContainer(contact: contact));
                },
                child: ContactItem(
                  name: contact.name,
                  account: contact.account.toString(),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text("Não há nenhum contato cadastrado."),
        );
      }),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) => const ContactForm(),
            ))
            .then(
              (_) => context.read<ContactsListCubit>().reload(dao),
            );
      },
      child: const Icon(Icons.add),
    );
  }
}
