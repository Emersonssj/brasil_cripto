import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/dependency_injection.dart';
import '../../../../shared/widgets/custom_card_widget.dart';
import '../blocs/favorite_coins_bloc.dart';
import '../blocs/favorite_coins_event.dart';
import '../blocs/favorite_coins_state.dart';

class FavoriteCoinsPage extends StatefulWidget {
  const FavoriteCoinsPage({super.key});

  @override
  State<FavoriteCoinsPage> createState() => _FavoriteCoinsPageState();
}

class _FavoriteCoinsPageState extends State<FavoriteCoinsPage> {
  late final FavoriteCoinsBloc _coinDetailsBloc;

  @override
  void initState() {
    _coinDetailsBloc = getDependency<FavoriteCoinsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showConfirmationDialog(BuildContext context, coinID) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirmar exclusão"),
            content: const Text("Tem certeza que deseja excluir este item dos favoritos?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar", style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.of(context).pop();
                  _coinDetailsBloc.add(RemoveFromFavoriteCoinsEvent(coinID));
                },
                child: const Text("Excluir", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Favoritos')),
      body: BlocBuilder<FavoriteCoinsBloc, FavoriteCoinsState>(
        bloc: _coinDetailsBloc,
        builder: (context, state) {
          if (state is FavoriteCoinsLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteCoinsLoadedState) {
            return Visibility(
              visible: state.coins.isNotEmpty,
              replacement: Center(child: Text('Lista vazia')),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: CustomCardWidget(
                  child: Column(
                    children: state.coins
                        .map(
                          (coin) => Row(
                            children: [
                              Image.network(coin.large, width: 32, height: 32),
                              SizedBox(width: 8),
                              Text(coin.name),
                              Expanded(child: SizedBox()),
                              IconButton(
                                onPressed: () => showConfirmationDialog(context, coin.id),
                                icon: Icon(Icons.delete, color: Colors.red, size: 28),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            );
          }

          if (state is FavoriteCoinsErrorState) {
            return Center(child: Text(state.message));
          }

          return SizedBox();
        },
      ),
    );
  }
}
