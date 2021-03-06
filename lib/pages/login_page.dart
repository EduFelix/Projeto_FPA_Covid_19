import 'package:flutter/material.dart';
import 'package:flutter_app/Home_Page.dart';
import 'package:flutter_app/pages/api_response.dart';
import 'package:flutter_app/pages/login_api.dart';
import 'package:flutter_app/pages/usuarios.dart';
import 'package:flutter_app/utius/alert.dart';
import 'package:flutter_app/utius/nav.dart';
import 'package:flutter_app/widgets/app_button.dart';
import 'package:flutter_app/widgets/app_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final  _tlogin = TextEditingController();

  final  _tsenha = TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prevenção Covid 19"),

      ),
      body: _body(),
    );
  }

  _body() {
      return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[

              AppText("Login", "Digite o login",
                  controller: _tlogin,
                  validator: _validateLogin,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  nextFocus: _focusSenha,
              ),
              SizedBox(height: 10,),
              AppText("Senha", "Digite a senha",
                  password: true,
                  controller: _tsenha,
                  validator: _validateSenha,
                  keyboardType: TextInputType.number,
                  focusNode: _focusSenha,
              ),
              SizedBox(height: 20,),
              AppButton("Login",
                  _onClickLogin),
            ],
          ),
        ),
      );
  }

  void _onClickLogin() async{
    if(!_formKey.currentState.validate()){
      return;
    }
    String login = _tlogin.text;
    String senha = _tsenha.text;
    print("Login: $login, Senha: $senha");
    ApiResponse response = await LoginApi.login(login, senha);
    if(response.ok){
      Usuarios user = response.result;
      print(">>> $user");
      push(context, HomePage(), replace: true);
    }
    else{
      alert(context, response.msg);
    }

  }

  String _validateLogin(String text) {
      if(text.isEmpty){
        return "Digite o login";
      }
      return null;
  }

  String _validateSenha(String text) {
    if(text.isEmpty){
      return "Digite a senha";
    }
    if(text.length<3){
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
