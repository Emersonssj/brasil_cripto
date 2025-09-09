import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/dependency_injection.dart';
import '../../../favorites_coins/presentation/blocs/favorite_coins_bloc.dart';
import '../../../favorites_coins/presentation/blocs/favorite_coins_event.dart';
import '../../../favorites_coins/presentation/blocs/favorite_coins_state.dart';
import '../../domain/entities/coin_entity.dart';

class FavoriteStarWidget extends StatefulWidget {
  const FavoriteStarWidget({super.key, required this.coin});

  final CoinEntity coin;

  @override
  State<FavoriteStarWidget> createState() => _FavoriteStarWidgetState();
}

class _FavoriteStarWidgetState extends State<FavoriteStarWidget> {
  late final FavoriteCoinsBloc _favoriteCoinsBloc;

  @override
  void initState() {
    _favoriteCoinsBloc = getDependency<FavoriteCoinsBloc>();
    super.initState();
  }

  Widget getCurrentIcon(FavoriteCoinsLoadedState state) {
    if (state.coins.any((favoriteCoin) => favoriteCoin.id == widget.coin.id)) {
      return IconButton(
        constraints: BoxConstraints(),
        onPressed: () {
          _favoriteCoinsBloc.add(RemoveFromFavoriteCoinsEvent(widget.coin.id));
        },
        icon: Icon(Icons.star, color: Colors.amber),
      );
    } else {
      return IconButton(
        constraints: BoxConstraints(),
        onPressed: () {
          _favoriteCoinsBloc.add(AddToFavoriteCoinsEvent(widget.coin));
        },
        icon: Icon(Icons.star_border_outlined),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCoinsBloc, FavoriteCoinsState>(
      bloc: _favoriteCoinsBloc,
      builder: (context, state) {
        if (state is FavoriteCoinsLoadedState) {
          return getCurrentIcon(state);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
