part of 'episodes_cubit.dart';

@immutable
abstract class EpisodesState {}

class EpisodesInitial extends EpisodesState {}


class EpisodesLoaded extends EpisodesState{
  final List<Episode> episodes;

  EpisodesLoaded(this.episodes);
}
