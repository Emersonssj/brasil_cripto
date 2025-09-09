import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/dependency_injection/dependency_injection.dart';
import '../../../../shared/widgets/custom_card_widget.dart';
import '../blocs/coin_details_bloc.dart';
import '../blocs/coin_details_event.dart';
import '../blocs/coin_details_state.dart';
import '../widgets/conections_widget.dart';
import '../widgets/description_widget.dart';
import '../widgets/statistics_widget.dart';
import '../widgets/values_chart/values_chart_widget.dart';

class CoinDetailsPage extends StatefulWidget {
  const CoinDetailsPage({super.key, required this.id});

  final String id;

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  late final CoinDetailsBloc _coinDetailsBloc;
  final numberFormatter = NumberFormat.compact(locale: 'en_US');

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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'US\$ ${numberFormatter.format(state.coin.coinMarketData.currentPriceUsd)}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  ValuesChartWidget(id: state.coin.id),
                  SizedBox(height: 8),
                  Text('Informações', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  CustomCardWidget(child: StatisticsWidget(marketData: state.coin.coinMarketData)),
                  SizedBox(height: 8),
                  Text('Links', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  CustomCardWidget(child: ConectionsWidget(link: state.coin.links)),
                  SizedBox(height: 8),
                  Text('Descrição', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  CustomCardWidget(
                    padding: EdgeInsetsGeometry.only(left: 16, right: 16, top: 0, bottom: 16),
                    child: DescriptionWidget(description: state.coin.description),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          );
        }

        if (state is GetCoinDetailsErrorState) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Erro: ${state.exception.userMessage}'),
                  SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () => _coinDetailsBloc.add(GetCoinDetailsEvent(widget.id)),
                    child: Text('Recarregar'),
                  ),
                ],
              ),
            ),
          );
        }

        return Center(child: Text('Erro desconhecido'));
      },
    );
  }
}
