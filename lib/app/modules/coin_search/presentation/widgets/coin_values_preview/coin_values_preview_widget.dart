import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'coin_values_preview_bloc.dart';
import 'coin_values_preview_event.dart';
import 'coin_values_preview_state.dart';

class CoinValuesPreviewWidget extends StatefulWidget {
  const CoinValuesPreviewWidget({super.key, required this.id});

  final String id;

  @override
  State<CoinValuesPreviewWidget> createState() => _CoinValuesPreviewWidgetState();
}

class _CoinValuesPreviewWidgetState extends State<CoinValuesPreviewWidget> {
  final CoinValuesPreviewBloc _coinSearchBloc = CoinValuesPreviewBloc();

  Widget getMarketChange(double value) {
    if (value > 1) {
      return Row(
        children: [
          Center(child: Icon(Icons.arrow_drop_up_sharp, size: 12)),
          Text('${value.toString()}%'),
        ],
      );
    } else {
      return Text('a');
    }
  }

  @override
  void initState() {
    _coinSearchBloc.add(GetValuesPreviewEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinValuesPreviewBloc, CoinValuesPreviewState>(
      bloc: _coinSearchBloc,
      builder: (context, state) {
        if (state is CoinValuesPreviewLoadingState) {
          return CircularProgressIndicator();
        }

        if (state is GetValuesPreviewSuccessState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('USD: ${state.previewValues.currentPrice}'),
              getMarketChange(state.previewValues.marketCapChangePercentage24h),
            ],
          );
        }

        return SizedBox();
      },
    );
  }
}
