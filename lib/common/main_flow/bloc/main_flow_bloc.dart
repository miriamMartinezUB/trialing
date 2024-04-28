import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialing/resoruces/drawer_item_id.dart';

part 'main_flow_event.dart';
part 'main_flow_state.dart';

class MainFlowBloc extends Bloc<MainFlowEvent, MainFlowState> {
  MainFlowBloc() : super(MainFlowState(DrawerItemId.home)) {
    on<ChangeMainScreenEvent>((event, emit) {
      emit(MainFlowState(event.itemId));
    });
  }
}
