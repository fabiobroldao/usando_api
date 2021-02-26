/*
2 Criar uma pasta services
  2.1 Criar uma classe CardService
     2.1.1 Criar método para recuperar todos os cards
     2.1.2 Criar método para recuperar card por id
     2.1.3 Criar método para salvar card
     2.1.4 Criar método para atualizar card
     2.1.5 Criar método para deletar card
*/

import 'package:dio/dio.dart';

import '../entities/card.dart';

class CardService {
  var url = 'https://api-cards-growdev.herokuapp.com';

  Future<List<Card>> getCards() async {
    try {
      var dio = Dio(BaseOptions(baseUrl: url));

      var response = await dio.get('/cards');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var cards =
            (response.data as List).map((e) => Card.fromMap(e)).toList();
        return cards;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Card> getCard(int id) async {
    try {
      var dio = Dio(BaseOptions(baseUrl: url));

      var response = await dio.get('/cards/$id');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var card = Card.fromMap(response.data);
        return card;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
