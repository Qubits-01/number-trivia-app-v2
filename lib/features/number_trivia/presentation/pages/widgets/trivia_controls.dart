// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state_holders/bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TriviaControlState createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControls> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number.',
          ),
          onSubmitted: (_) => _addGetBtnPressedEvent(),
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                child: const Text('Search'),
                onPressed: _addGetBtnPressedEvent,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ElevatedButton(
                child: const Text('Get Random Trivia'),
                onPressed: _addRandomBtnPressedEvent,
              ),
            ),
          ],
        )
      ],
    );
  }

  void _addGetBtnPressedEvent() {
    // Clearing the TextField to prepare it for the next inputted number.
    BlocProvider.of<NumberTriviaBloc>(context).add(
      NumberTriviaGetBtnPressed(numberString: controller.text),
    );
    controller.clear();
  }

  void _addRandomBtnPressedEvent() {
    BlocProvider.of<NumberTriviaBloc>(context).add(
      const NumberTriviaRandomBtnPressed(),
    );
    controller.clear();
  }
}
