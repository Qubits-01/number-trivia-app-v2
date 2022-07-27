import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state_holders/bloc/number_trivia_bloc.dart';
import '../../../../injection_container.dart';

import 'widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number Trivia')),
      body: BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                // Top Half.
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is NumberTriviaInitial) {
                      return const MessageDisplay(message: 'Start Searching!');
                    } else if (state is NumberTriviaLoadInProgress) {
                      return const LoadingDisplay();
                    } else if (state is NumberTriviaLoadSuccess) {
                      return TriviaDisplay(
                          numberTriviaEntity: state.numberTriviaEntity);
                    } else if (state is NumberTriviaLoadFailure) {
                      return MessageDisplay(message: state.errorMessage);
                    } else {
                      return const Text('Error');
                    }
                  },
                ),
                const SizedBox(height: 10),
                // Bottom Half.
                const TriviaControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
