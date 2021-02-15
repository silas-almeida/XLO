import 'package:flutter/material.dart';
import 'package:xlo_mobx2/screens/signup/signup-screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
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
                    Text(
                      'Acessar com e-mail',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3, bottom: 4, top: 8.0),
                      child: Text(
                        'E-mail',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3, bottom: 4, right: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Senha',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      obscureText: true,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: Text('Entrar'),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text('Não tem uma conta?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14)),
                          SizedBox(
                            width: 4.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => SignupScreen()));
                            },
                            child: Text(
                              'Cadastre-se!',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )
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
