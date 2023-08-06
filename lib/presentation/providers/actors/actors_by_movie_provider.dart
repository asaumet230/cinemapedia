import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';
import 'actors_repository_provider.dart';

//Casos de uso:

final actorsInfoProvider =
    StateNotifierProvider<ActorsMapNotifier, Map<String, List<Actor>>>(
  (ref) {
    final getActorsInfo = ref.watch(actorsRepositoryProvider).getActorsById;
    return ActorsMapNotifier(getActors: getActorsInfo);
  },
);

/*
  {
    '45678':Actor[],
    '45679':Actor[],
    '45677':Actor[],
    '45676':Actor[],
  }
 */

typedef GetActorsCallBack = Future<List<Actor>> Function(String movieId);

class ActorsMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallBack getActors;

  ActorsMapNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
