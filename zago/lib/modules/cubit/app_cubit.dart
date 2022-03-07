import 'package:bloc/bloc.dart';
import 'package:zago/common/abstract/my_loc.dart';
import 'package:zago/modules/cubit/app_cubit_states.dart';
import 'package:zago/modules/messages/model/messsage.dart';
import 'package:zago/modules/messages/repo/message_repo.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits(this.messageRepo) : super(InitialState()) {
    emit(WelcomeState());
  }

  final MessageRepo messageRepo;
  late final List<Message> list;
  Future<void> getData() async {
    try {
      emit(LoadingState());
      list = await messageRepo.getListMessage();
      emit(LoadedState(list));
    } catch (e) {
      dlog(e);
    }
  }
}
