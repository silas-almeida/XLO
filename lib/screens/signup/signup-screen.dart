import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx2/screens/signup/components/field_title.dart';
import 'package:xlo_mobx2/stores/signup_store.dart';

class SignupScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular((16))),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FieldTitle('Apelido', 'Como aparecerá em seus anúncios'),
                    Observer(
                      builder: (_) => TextField(
                        onChanged: signupStore.setName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          hintText: 'Exemplo: João da Silva',
                          errorText: signupStore.nameError,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FieldTitle('E-mail', 'Enviaremos um e-mail de confirmação'),
                    Observer(
                      builder: (_) => TextField(
                        onChanged: signupStore.setEmail,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          errorText: signupStore.emailError,
                          isDense: true,
                          hintText: 'João@gmail.com',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FieldTitle('Celular', 'proteja sua conta'),
                    Observer(
                      builder: (_) => TextField(
                        onChanged: signupStore.setPhone,
                        decoration: InputDecoration(
                            errorText: signupStore.phoneError,
                            border: OutlineInputBorder(),
                            isDense: true,
                            hintText: '(99) 99999-9999'),
                        keyboardType: TextInputType.phone,
                        autocorrect: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                        'Senha', 'Use letras, números e caracteres especiais'),
                    Observer(
                      builder: (_) => TextField(
                        onChanged: signupStore.setPass1,
                        decoration: InputDecoration(
                          errorText: signupStore.pass1Error,
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FieldTitle('Confirmar senha', 'proteja sua conta'),
                    Observer(
                      builder: (_) => TextField(
                        onChanged: signupStore.setPass2,
                        decoration: InputDecoration(
                          errorText: signupStore.pass2Error,
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: Text('Cadastrar'),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            'Já tem uma conta?',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: Navigator.of(context).pop,
                            child: Text(
                              'Entrar!',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
