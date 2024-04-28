import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialing/resoruces/main_pages_id.dart';

part 'main_flow_event.dart';
part 'main_flow_state.dart';

class MainFlowBloc extends Bloc<MainFlowEvent, MainFlowState> {
  MainFlowBloc() : super(MainFlowState(MainPagesId.home)) {
    on<ChangeMainScreenEvent>((event, emit) {
      emit(MainFlowState(event.itemId));
    });
  }
}
