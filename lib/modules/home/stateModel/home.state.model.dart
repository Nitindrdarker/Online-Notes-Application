import 'package:flutter/cupertino.dart';
import 'package:online_todo/modules/home/models/notes.dart';

class HomeStateModel {
  final List<Notes> notes;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  HomeStateModel({
    this.notes = const [],
    this.page = 0,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  HomeStateModel copyWith({
    List<Notes>? notes,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return HomeStateModel(
      notes: notes ?? this.notes,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
