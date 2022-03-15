import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:oxoo/server/repository.dart';
import '../../bloc/home_content/home_content_event.dart';
import '../../bloc/home_content/home_content_state.dart';
import '../../models/home_content.dart';

class HomeContentBloc extends Bloc<HomeContentEvent, HomeContentState> {
  final Repository repository;

  HomeContentBloc({required this.repository}) : super(HomeContentLoadingState());

  @override
  Stream<HomeContentState> mapEventToState(HomeContentEvent event) async* {
    if (event is FetchHomeContentData) {
      yield HomeContentLoadingState();
      try {
        HomeContent homeContent = await repository.getHomeContent();
        yield HomeContentLoadedState(homeContent: homeContent);
      } catch (_) {
        yield HomeContentErrorState();
      }
    }
  }
}
