import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zago/modules/cubit/app_cubit.dart';
import 'package:zago/modules/cubit/app_cubit_states.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({Key? key}) : super(key: key);

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FPT')),
      body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
        if (state is WelcomeState) {
          return Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: const Text('Cubit'),
                onPressed: () {
                  BlocProvider.of<AppCubits>(context).getData();
                },
              ));
        }
        if (state is LoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.red));
        }
        if (state is LoadedState) {
          return Text(state.listMessage.toString());
        } else {
          return Container();
        }
      }),
    );
  }
}
