import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/dependency_injection.dart';
import '../../../../shared/widgets/custom_card_widget.dart';
import '../blocs/coin_details_bloc.dart';
import '../blocs/coin_details_event.dart';
import '../blocs/coin_details_state.dart';
import '../widgets/conections_widget.dart';
import '../../../../shared/widgets/favorite_star_widget.dart';
import '../widgets/historic_data_widget.dart';
import '../widgets/statistics_widget.dart';
import '../widgets/values_chart_widget.dart';

class CoinDetailsPage extends StatefulWidget {
  const CoinDetailsPage({super.key, required this.id});

  final String id;

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  late final CoinDetailsBloc _coinDetailsBloc;

  @override
  void initState() {
    _coinDetailsBloc = getDependency<CoinDetailsBloc>();
    _coinDetailsBloc.add(GetCoinDetailsEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
      bloc: _coinDetailsBloc,
      builder: (context, state) {
        if (state is CoinDetailsLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is GetCoinDetailsSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Image.network(state.coin.image, height: 38, width: 38),
                  SizedBox(width: 4),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(state.coin.symbol.toUpperCase(), style: TextStyle(fontSize: 14)),
                          Text('  #${state.coin.marketCapRank.toString()}', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Text(state.coin.name),
                    ],
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                children: [
                  ValuesChartWidget(),
                  SizedBox(height: 8),
                  CustomCardWidget(title: 'Estatísticas', child: StatisticsWidget()),
                  SizedBox(height: 8),
                  HistoricDataWidget(),
                  SizedBox(height: 8),
                  CustomCardWidget(
                    title: 'Links',
                    child: ConectionsWidget(link: state.coin.links),
                  ),
                  SizedBox(height: 8),
                  CustomCardWidget(title: 'Descrição', child: Text(state.coin.description)),
                  SizedBox(height: 8),
                ],
              ),
            ),
          );
        }

        if (state is GetCoinDetailsErrorState) {
          return Scaffold(appBar: AppBar(title: Text('Error')));
        }

        return Center(child: Text('Erro desconhecido'));
      },
    );
  }
}
