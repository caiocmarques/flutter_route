import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.symmetric(vertical: 84.0),
          child: Column(
            children: [
              Image.asset(
                'assets/login.png',
                height: 75,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(labelText: "E-mail"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Senha"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () => onButtonEntrarClicked(context), child: Text('Entrar'))
            ],
          ),
        ),
      ),
    );
  }
}

void onButtonEntrarClicked (BuildContext context){
 Navigator.of(context).pushReplacementNamed("/dashboard");
}
