import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/coin_market_data_entity.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key, required this.marketData});

  final CoinMarketDataEntity marketData;

  @override
  Widget build(BuildContext context) {
    final data = {
      'Valor de mercado': marketData.marketCapUsd,
      'Volume (24h)': marketData.totalVolumeUsd,
      'Máximo (24h)': marketData.high24hUsd,
      'Mínimo (24h)': marketData.low24hUsd,
      'Fornecimento circulante': marketData.circulatingSupply,
    };

    final dataEntries = data.entries.toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final entry = dataEntries[index];
        final String title = entry.key;
        final double value = entry.value;

        final currencyFormatter = NumberFormat.compactSimpleCurrency(locale: 'en_US');
        final numberFormatter = NumberFormat.compact(locale: 'en_US');

        final String formattedValue = title == 'Fornecimento circulante'
            ? numberFormatter.format(value)
            : currencyFormatter.format(value);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              formattedValue,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
