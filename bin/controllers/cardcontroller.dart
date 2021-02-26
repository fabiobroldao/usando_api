/*
3. Criar uma pasta Controllers
 3.1 Criar uma classe CardController
   3.1.1 Criar uma propriedade de CarService
   3.1.2 Criar método para recuperar todos os cards
   3.1.3 Criar método para recuperar card por ID
   3.1.4 Criar método para salvar card
   3.1.5 Criar método para atualizar o card
   3.1.6 Criar método para remover card
*/

import '../entities/card.dart';
import '../services/cardservice.dart';

class CardController {
  CardService cs = CardService();

  Future<List<Card>> fetch() async {
    try {
      return await cs.getCards();
    } finally {}
  }

  Future<Card> getCard(int id) async {
    try {
      return await cs.getCard(id);
    } finally {}
  }

  Future<Card> postCard(String title, String content) async {
    try {
      var cards = await cs.getCards();
      var id = cards.last.id + 1;
      await cs.postCard(id, title, content);
      return await cs.getCard(id);
    } finally {}
  }

  Future<Card> deleteCard(int id) async {
    try {
      var cards = await cs.getCards();

      for (var i = 0; i < cards.length; i++) {
        if (cards[i].id == id) {
          return await cs.deleteCard(id);
        }
      }

      return null;
    } finally {}
  }

  Future<Card> updateCard(int id, String title, String content) async {
    try {
      var resposta = await cs.updateCard(id, title, content);
      if (resposta != null) {
        return await cs.getCard(id);
      }
      return null;
    } finally {}
  }
}
