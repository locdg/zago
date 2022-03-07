import 'package:equatable/equatable.dart';
import 'package:zago/modules/messages/model/messsage.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {

  @override
  List<Object> get props => [];
}

class WelcomeState extends CubitStates {
  @override
  List<Object> get props => [];
}

class LoadingState extends CubitStates {
  @override
  List<Object> get props => [];
}

class LoadedState extends CubitStates {
  LoadedState(this.listMessage);
  final List<Message> listMessage;
  @override
  List<Object> get props => [listMessage];
}
