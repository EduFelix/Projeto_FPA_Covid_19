import 'package:flutter_app/utius/prefs.dart';
import 'dart:convert' as convert;

class Usuarios {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  Usuarios(
      {this.id,
        this.login,
        this.nome,
        this.email,
        this.urlFoto,
        this.token,
        this.roles});

  Usuarios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }
  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("user.prefs", json);
  }
  static Future<Usuarios> get() async{
    String json = await Prefs.getString("user.prefs");
    if(json.isEmpty){
      return null;
    }
    Map map = convert.json.decode(json);
    Usuarios user = Usuarios.fromJson(map);
    return user;

  }

  @override
  String toString() {
    return 'Usuarios{id: $id, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles}';
  }

}
