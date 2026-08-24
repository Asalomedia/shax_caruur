import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shax_caruur/state_management/home_states.dart'
    show HomeStates, InitialState;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());
}
