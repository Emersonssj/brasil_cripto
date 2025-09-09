import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/dependency_injection.dart';
import '../blocs/home_bloc.dart';
import '../blocs/home_event.dart';
import '../blocs/home_state.dart';
import '../widgets/trending_coin_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = getDependency<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/icons/icon.png', width: 38, height: 38),
            SizedBox(width: 6),
            Text('BrasilCripto'),
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is GetTrendingsSuccessState) {
            return TrendingCoinWidget(coins: state.coins);
          }

          if (state is GetTrendingsErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Erro: ${state.exception.userMessage}'),
                  SizedBox(height: 6),
                  ElevatedButton(onPressed: () => _homeBloc.add(GetTrendingCoinsEvent()), child: Text('Recarregar')),
                ],
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
