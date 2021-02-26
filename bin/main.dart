/*
E aí galerinhaaaaaaaaaa, vamos ao um desafio?

Então, eu tenho uma API que está lá no Heroku (Uma plataforma para fazer deploy e disponibilizar aplicações), 
essa API ela foi feita no Programa Starter aqui na growdev, e tem algumas funcionalidades, como criar, atualizar, deletar e consultar cards.

O desafio vai ser interagir com essa API e exercitar requisições para API's, tratativas de erros e programação assíncrona.

Para esse desafio é preciso fazer "uma interface" (interface de usuário, com opções onde o usuário interage) 
para o usuário ficar interagindo até querer sair, então mais ou menos deve ser assim a saída:

==========================================
Bem-vindo ao sistema de Cards o/

Escolha uma das opções:
1 - Buscar todos os cards (verbo: GET, url: /cards)
2 - Buscar card pelo ID  (verbo: GET, url: /cards/ID )
3 - Criar card (verbo: POST, url: /cards, data: objeto para criar)
4 - Atualizar card (verbo: PUT, url: /cards/ID, data: objeto para atualizar)
5 - Deletar card (verbo: DELETE, url: /cards/ID)
6 - Sair
===========================================
Notem, que temos as opções e a última é a opção de Sair, então o programa deve continuar rodando até o usuário escolher a opção 6 que é sair.

Conforme a opção que o usuário escolher, precisa ter entradas diferentes, vamos lá:

Opção 1: Buscar todos os cards
Não deve pedir entrada nenhuma e deve somente buscar todos os cards da API e mostrar no terminal os cards

Opção 2: Buscar card pelo ID
Deve pedir o ID do card para o usuário digitar e depois buscar o card deste ID

Opção 3:  Criar card
Deve pedir o título e o conteúdo que vão aparecer no card

Opção 4: Atualizar card
Deve pedir o ID do card a ser atualizado e também pedir o novo título e conteúdo do card

Opção 5: Deletar card
Deve pedir o ID do card a ser deletado

Opção 6: Sair
Finalizar o programa com o saída: 
===========================
Saíndo do sistema....
Valeu, falows \o
===========================

FEITO: Para esse desafio vocês vão criar a seguinte estrutura:
FEITO: 1. Criar uma pasta entities
FEITO:   1.1 Dentro da pasta entities criar uma classe chamada Card com as seguintes características
FEITO:        1.1.1 int id
FEITO:        1.1.2 String title
FEITO:        1.1.3 String content
FEITO:        1.1.4 Construtor normal que recebe id, title e content
FEITO:        1.1.4 Construtor com nome fromJson que pega os valores do map e coloca nos atributos
FEITO:        1.1.5 Método toJson() que retorna um map com as informações do Card

2 Criar uma pasta services
  2.1 Criar uma classe CardService
     2.1.1 Criar método para recuperar todos os cards
     2.1.2 Criar método para recuperar card por id
     2.1.3 Criar método para salvar card
     2.1.4 Criar método para atualizar card
     2.1.5 Criar método para deletar card

3. Criar uma pasta Controllers
 3.1 Criar uma classe CardController
   3.1.1 Criar uma propriedade de CarService
   3.1.2 Criar método para recuperar todos os cards
   3.1.3 Criar método para recuperar card por ID
   3.1.4 Criar método para salvar card
   3.1.5 Criar método para atualizar o card
   3.1.6 Criar método para remover card


Dentro do arquivo main aí vocês desenvolvem o menu e pegam as entradas pelo terminal conforme a opção e enviam para a classe Controler fazer a lógica.

URL_BASE: https://api-cards-growdev.herokuapp.com
*/
import 'dart:io';

import 'controllers/cardcontroller.dart';

void main() async {
  String opcao;
  var menu = '''
  ==========================================
  Bem-vindo ao sistema de Cards o/

  Escolha uma das opções:
  1 - Buscar todos os cards (verbo: GET, url: /cards)
  2 - Buscar card pelo ID  (verbo: GET, url: /cards/ID )
  3 - Criar card (verbo: POST, url: /cards, data: objeto para criar)
  4 - Atualizar card (verbo: PUT, url: /cards/ID, data: objeto para atualizar)
  5 - Deletar card (verbo: DELETE, url: /cards/ID)
  6 - Sair
  ===========================================

  ''';
  print(menu);
  while (opcao != '6') {
    var cc = CardController();
    print('Informe uma nova opção:');
    opcao = stdin.readLineSync();
    switch (opcao) {
      case '1':
        var cards = await cc.fetch();
        cards.forEach((c) {
          print(c.toMap());
        });
        break;

      case '2':
        print('Digite um código de card:');
        var card = await cc.getCard(int.tryParse(stdin.readLineSync()));
        print(card.toMap());
        break;

      case '3':
        print('Digite o título do novo card:');
        var title = stdin.readLineSync();
        print('Digite o conteúdo do novo card:');
        var content = stdin.readLineSync();
        var card = await cc.postCard(title, content);
        print(card.toMap());
        break;

      case '4':
        print('Digite o código de card a ser atualizado:');
        var id = int.tryParse(stdin.readLineSync());
        print('Digite um novo título para o card nº $id:');
        var title = stdin.readLineSync();
        print('Digite um novo conteúdo para o card nº $id:');
        var content = stdin.readLineSync();
        var resposta = await cc.updateCard(id, title, content);
        if (resposta != null) {
          print('Código ${resposta.id} atualizado!');
        } else
          print('Código Não encontrado!');
        break;

      case '5':
        print('Digite o código de card a ser excluído:');
        await cc.deleteCard(int.tryParse(stdin.readLineSync()));
        print('Card excluído com sucesso!');
        break;

      default:
    }
    //print('$opcao : não é 6! portanto... vamos em frente...');
  }

  print('''

  ===========================
  Saíndo do sistema....
  Valeu, falows \o
  ===========================
  ''');
}
