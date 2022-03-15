import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:oxoo/models/home_content.dart';

@immutable
abstract class HomeContentState extends Equatable {}

class HomeContentInitialState extends HomeContentState {
  @override
  List<Object?> get props => [];
}

class HomeContentLoadingState extends HomeContentState {
  @override
  List<Object?> get props => [];
}

class HomeContentLoadedState extends HomeContentState {
  final HomeContent homeContent;
  HomeContentLoadedState({required this.homeContent});

  @override
  List<Object> get props => [homeContent];
}

class HomeContentErrorState extends HomeContentState {
  @override
  List<Object?> get props => [];
}
