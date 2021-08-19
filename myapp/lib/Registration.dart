import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './Login.dart';

class account_Info {
  final String? userName;
  final String? pwd;
  final String? email;

  const account_Info(this.userName, this.pwd, this.email);
}

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String? name;
  String? password;
  String? repassword;
  String? email;

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _confirmemailController = new TextEditingController();
  bool pwdShow = false; //password not display
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                    labelText: 'User Name:',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter User name';
                    }else{
                      //@lovedeep this is the name input
                      name = value;
                      //debugPrint('name: $name');
                      return null;
                    }

                  },
                ),

                TextFormField(
                  controller: _pwdController,
                  autofocus: true,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password:',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }else{
                      //@lovedeep this is password input
                      password = value;
                      //debugPrint('password: $password');
                      return null;
                    }

                  },
                ),

                TextFormField(
                  controller: _confirmemailController,
                  autofocus: true,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Confirm Password:',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter password';
                    }else if (password != value){
                      return 'password does not match';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _emailController,
                  autofocus: true,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email:',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter User name';
                    }else{
                      //@lovedeep this is the email input
                      email = value;
                      //debugPrint('email: $email');
                      return null;
                    }
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      //style: style,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          account_Info info = account_Info(
                              name, password, email);
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => Login(info: info)));
                        }
                      },
                      child: const Text('Create'),
                    ),
                  ),
                ),

              ]
          )
        )
      ),
    );
  }
}