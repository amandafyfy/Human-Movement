import 'package:flutter/material.dart';

class account_Info {
  final String? userName;
  final String? pwd;

  const account_Info(this.userName, this.pwd);
}

class Registration extends StatefulWidget {
  //final account_Info info;
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

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
                    labelText: 'Password:',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
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
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter password';
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
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter User name';
                    }
                    return null;
                  },
                ),
              ]
          )
        )
      ),
    );
  }
}