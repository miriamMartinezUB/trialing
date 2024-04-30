import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialing/resoruces/main_pages_id.dart';
import 'package:uuid/uuid.dart';

part 'main_flow_event.dart';
part 'main_flow_state.dart';

class MainFlowBloc extends Bloc<MainFlowEvent, MainFlowState> {
  MainFlowBloc() : super(MainFlowState(MainPagesId.home)) {
    MainPagesId currentPageId = MainPagesId.home;
    on<ChangeMainScreenEvent>((event, emit) {
      currentPageId = event.itemId;
      emit(MainFlowState(event.itemId, key: Key(const Uuid().v4())));
    });
    on<RefreshMainScreenEvent>((event, emit) {
      emit(MainFlowState(currentPageId, key: Key(const Uuid().v4())));
    });
  }
}
