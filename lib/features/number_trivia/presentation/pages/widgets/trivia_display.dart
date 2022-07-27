import 'package:flutter/material.dart';

import '../../../domain/entities/number_trivia_entity.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTriviaEntity numberTriviaEntity;

  const TriviaDisplay({
    Key? key,
    required this.numberTriviaEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          // Fixed size, doesn't scroll.
          Text(
            numberTriviaEntity.number.toString(),
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Expanded - makes it fill in all the remaining space.
          Expanded(
            child: Center(
              // Only the trivia 'message' part will be scrollable.
              child: Text(
                numberTriviaEntity.text,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
