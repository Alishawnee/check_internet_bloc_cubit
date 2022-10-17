import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/internet_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: BlocConsumer<InternetCubit, InternetState>(
        buildWhen: (previousState, currentState) =>
            previousState != currentState,
        listener: (context, state) {
          if (state is NotConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is ConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ));
          }
        },
        builder: (context, state) {
          if (state is ConnectedState) {
            return _buildTextWidget(state.message, Colors.green);
          } else if (state is NotConnectedState) {
            return _buildTextWidget(state.message, Colors.red);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildTextWidget(String message, Color color) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 20, color: color),
      ),
    );
  }
}
