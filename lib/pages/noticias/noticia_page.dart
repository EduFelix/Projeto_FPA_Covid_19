
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/covid.dart';
import 'package:flutter_app/pages/locais_hospitais.dart';
import 'package:flutter_app/pages/noticias/noticia_Recente.dart';
import 'package:flutter_app/utius/alert.dart';
import 'package:flutter_app/utius/nav.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NoticiaPage extends StatelessWidget {
  NoticiaRecente noticia;
  NoticiaPage(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(noticia.nome),
        actions: <Widget> [
          IconButton(icon: Icon(Icons.place),
              onPressed: _onClickMapa()),
          IconButton(icon: Icon(Icons.videocam),
              onPressed: (){
                _onClickVideo(context);
              } ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    WebView(
      initialUrl: noticia.urlVideo,
    );
    //return Container(
        //padding: EdgeInsets.all(16),
       // child: ListView(
         // children: <Widget> [
          //  Image.network(noticia.urlFoto),
           // _bloco1(),
           // Divider(),
           // _bloco2(),
         // ],
       // ));
    //Center(
    //  child: new RaisedButton(
     //   onPressed: _launchURL,
      //  child: new Text('Show Flutter homepage'),
     // ),
   // );
  }

  Row _bloco1() {
    return Row(
            children:<Widget> [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(noticia.nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  )
                ],
              )
            ],
          );
  }

  _onClickMapa() {}

  _onClickVideo(context) {
    if(noticia.urlVideo != null && noticia.urlVideo.isNotEmpty){

      launch(noticia.urlVideo);
    }
    else{
      alert(context, "Erro");
    }

  }

  onClickPopupMenu(String value) {
    switch(value){
      case "Hospitais":
        print("Hospitais");
        break;
      case "Graficos":
        print("Graficos");
        break;
      case "Share":
        print("Share");
        break;
    }
  }

  _bloco2() {
    return Column(
      children: <Widget> [
         Text(noticia.desc),
      ],

    );
  }

}

_launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}