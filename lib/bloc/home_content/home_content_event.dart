import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeContentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHomeContentData extends HomeContentEvent {}
