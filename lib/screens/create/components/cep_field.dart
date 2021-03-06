import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx2/stores/cep_store.dart';
import 'package:xlo_mobx2/stores/create_store.dart';

class CepField extends StatelessWidget {
  CepField(this.createStore) : cepStore = createStore.cepStore;

  final CreateStore createStore;
  final CepStore cepStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(
          builder: (_) => TextFormField(
            initialValue: cepStore.cep,
            keyboardType: TextInputType.number,
            onChanged: cepStore.setCep,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            decoration: InputDecoration(
              errorText: createStore.addressError,
              labelText: 'CEP',
              labelStyle: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                fontSize: 18,
              ),
              contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
            ),
          ),
        ),
        Observer(
          builder: (_) {
            if (cepStore.address == null &&
                cepStore.error == null &&
                !cepStore.loading) {
              return Container();
            } else if (cepStore.address == null && cepStore.error == null) {
              return LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.purple),
                backgroundColor: Colors.transparent,
              );
            } else if (cepStore.error != null) {
              return Container(
                color: Colors.red.withAlpha(100),
                height: 50,
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Text(
                  cepStore.error,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                ),
              );
            } else {
              final address = cepStore.address;
              return Container(
                color: Colors.purple.withAlpha(150),
                height: 50,
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Text(
                  'Localiza????o ${address.district}, ${address.city.name} - ${address.uf.initials}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
