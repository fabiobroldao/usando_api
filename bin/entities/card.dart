import 'dart:convert';

/*
1. Criar uma pasta entities
  1.1 Dentro da pasta entities criar uma classe chamada Card com as seguintes características
       1.1.1 int id
       1.1.2 String title
       1.1.3 String content
       1.1.4 Construtor normal que recebe id, title e content
       1.1.4 Construtor com nome fromJson que pega os valores do map e coloca nos atributos
       1.1.5 Método toJson() que retorna um map com as informações do Card
*/

class Card {
  int id;
  String title;
  String content;

  Card({this.id, this.title, this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  factory Card.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Card(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Card.fromJson(String source) => Card.fromMap(json.decode(source));
}
