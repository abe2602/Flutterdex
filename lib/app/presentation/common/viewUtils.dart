import 'package:flutter/material.dart';

Widget loading(){
  return Center(child: CircularProgressIndicator());
}

Widget internetEmptyState(Function tryAgain){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Text("Parece que você está sem internet! \n Tente conectar-se em alguma rede! ;)"),
            ),
          ),
        ),
        Image.asset('images/internetEmptyState.png', fit: BoxFit.cover,),
        Expanded(
          child: Container(
            color: Colors.white,
            child: Center(
              child: RaisedButton(
                onPressed: () => tryAgain(),
                child: Text("Tente novamente!"),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}