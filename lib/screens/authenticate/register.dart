import 'package:flutter/material.dart';
import 'package:reconnect/services/auth.dart';

class Register extends StatefulWidget {

	final Function toggleView;
	Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

	final AuthService _auth = AuthService();
	final _formKey = GlobalKey<FormState>();

	// text field state
	String email = "";
	String password = "";
	String error = "";

	@override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Colors.brown[100],
			appBar: AppBar(
				backgroundColor: Colors.brown[400],
				elevation: 0.0,
				title: Text("Sign UP"),
				actions: <Widget>[
					FlatButton.icon(
							onPressed: () {widget.toggleView();},
							icon: Icon(Icons.person),
							label: Text("SignIn"))
				],
			),
			body: Container(
				padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
				child: Form(
					key: _formKey,
					child: Column(
						children: <Widget>[
							SizedBox(height: 10,),
							TextFormField(
								validator: (val) => val.isEmpty ? "Enter an email" : null,
								onChanged: (val) {setState(() => email = val);},
							),
							SizedBox(height: 10,),
							TextFormField(
								validator: (val) => val.length < 6 ? "Enter a longer password" : null,
								obscureText:true,
								onChanged: (val) {setState(() => password = val);},),
							SizedBox(height: 20,),
							RaisedButton(
								color: Colors.pink[400],
								child: Text(
									"Register",
									style: TextStyle(color: Colors.white),
								),
								onPressed: () async {
									if(_formKey.currentState.validate()){
										dynamic result = await _auth.registerWithEmailAndPassword(email, password);
										if(result == null){
											setState(() {
											  error = "Firebase validation failed";
											});
											print(error);
										}
									}
									else{
										print("form validation faild");
									}
								},
							),
						],
					),
				),
			),
		);
  }
}