import 'package:flutter/material.dart';
import './Registration.dart';

class Login extends StatefulWidget {

  const Login({Key? key, required this.info}) : super(key: key);
  final account_Info info;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //password not display
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _unameController = TextEditingController(text: widget.info.userName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _unameController,
                autofocus: true,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your username:',
                    prefixIcon: Icon(Icons.person),
                ),
                //lovedeep this is where username. it should exist in our db.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter User name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: true,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your password:',
                  prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    )
                ),
              obscureText: !pwdShow,
              //lovedeep this is the password, it should match our database.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter User name';
                }
                return null;
              },
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: new Column(
                  //constraints: BoxConstraints.expand(height: 55.0),
                  children: [
                    new Container(
                      constraints: BoxConstraints.expand(height: 55.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
                          }
                        },
                        child: const Text('Log In'),
                      ),
                    ),
                  new Container(
                    constraints: BoxConstraints.expand(height: 55.0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Create new account'),
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => Registration()));
                          }
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}