import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlo_mobx2/stores/edit_account_store.dart';
import 'package:xlo_mobx2/stores/page_store.dart';

class EditAccountScreen extends StatelessWidget {
  final EditAccountStore store = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LayoutBuilder(builder: (_, constraints) {
                    return Observer(builder: (_) {
                      return IgnorePointer(
                        ignoring: store.loading,
                        child: ToggleSwitch(
                          labels: ['Particular', 'Profissional'],
                          cornerRadius: 20,
                          minWidth: constraints.biggest.width / 2.01,
                          activeBgColor: Colors.purple,
                          inactiveBgColor: Colors.grey,
                          activeFgColor: Colors.white,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: store.userType.index,
                          onToggle: store.setUserType,
                        ),
                      );
                    });
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Nome *',
                            border: OutlineInputBorder(),
                            errorText: store.nameError),
                        initialValue: store.name,
                        enabled: !store.loading,
                        onChanged: store.setName,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Telefone *',
                          border: OutlineInputBorder(),
                          errorText: store.phoneError),
                      enabled: !store.loading,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                      initialValue: store.phone,
                      onChanged: store.setPhone,
                    );
                  }),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Nova Senha',
                            border: OutlineInputBorder(),
                            errorText: store.passError),
                        enabled: !store.loading,
                        obscureText: true,
                        onChanged: store.setPass1,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Confirmar Nova Senha',
                          border: OutlineInputBorder(),
                        ),
                        enabled: !store.loading,
                        obscureText: true,
                        onChanged: store.setPass2,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Observer(builder: (_) {
                    return SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.orange.withAlpha(120);
                              } else {
                                return Colors.orange;
                              }
                            },
                          ),
                        ),
                        onPressed: store.savePressed,
                        child: store.loading
                            ? Transform.scale(
                                scale: 0.7,
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ))
                            : Text(
                                'Salvar',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.red,
                          )),
                      onPressed: () {
                        store.logout();
                        GetIt.I<PageStore>().setPage(0);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Sair',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
