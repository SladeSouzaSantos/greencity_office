import 'package:flutter/material.dart';

import '../components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const LoginHeader(),
            const Headline1(text: "Login"),

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Senha",
                          icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                        ),
                        obscureText: true,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ElevatedButton(
                        onPressed: null,
                        child: Text("Entrar".toUpperCase()),
                      ),
                    ),

                    TextButton.icon(
                        onPressed: (){

                        },
                        icon: const Icon(Icons.person),
                        label: const Text("Criar Conta")
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
