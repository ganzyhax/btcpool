import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'workers_event.dart';
part 'workers_state.dart';

class WorkersBloc extends Bloc<WorkersEvent, WorkersState> {
  WorkersBloc() : super(WorkersInitial()) {
    int selectedTab = 0;
    on<WorkersEvent>((event, emit) async {
      if (event is WorkersLoad) {
        emit(WorkersLoaded(selectedTab: selectedTab));
      }
      if (event is WorkersChangeIndex) {
        selectedTab = event.index;
        emit(WorkersLoaded(selectedTab: selectedTab));
      }
    });
  }
}
