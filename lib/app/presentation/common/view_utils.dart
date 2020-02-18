import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget loading() => const Center(child: CircularProgressIndicator());

Widget internetEmptyState(Function tryAgain) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text('Parece que você está sem internet! '
                    '\n Tente conectar-se em alguma rede! ;)'),
              ),
            ),
          ),
          Image.asset(
            'images/internetEmptyState.png',
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: RaisedButton(
                  onPressed: () => tryAgain(),
                  child: const Text('Tente novamente!'),
                ),
              ),
            ),
          ),
        ],
      ),
    );

Widget favoriteImageAsset(bool isFavorite) => Image.asset(
      isFavorite ? 'images/favorite.png' : 'images/unfavorite.png',
      height: 20,
      width: 20,
      fit: BoxFit.scaleDown,
    );

Widget internetImage(String url) => CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Center(
          child: Image.asset(
        'images/no_image.png',
        fit: BoxFit.cover,
      )),
      fit: BoxFit.cover,
    );
