import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../coin_details/presentation/pages/coin_details_page.dart';
import '../../domain/entities/trending_coin_entity.dart';

class TrendingCoinWidget extends StatelessWidget {
  const TrendingCoinWidget({super.key, required this.coins});

  final List<TrendingCoinEntity> coins;

  @override
  Widget build(BuildContext context) {
    String formatCurrency(double value) {
      final format = NumberFormat.currency(locale: 'en_US', symbol: 'US\$ ', decimalDigits: value < 10 ? 6 : 2);
      return format.format(value);
    }

    String formatMarketCap(double value) {
      final format = NumberFormat.currency(locale: 'en_US', symbol: 'US\$ ', decimalDigits: 0);
      return format.format(value);
    }

    Widget buildHeader() {
      const textStyle = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            const Expanded(flex: 2, child: Text('#', style: textStyle)),
            const Expanded(flex: 3, child: Text('Moeda', style: textStyle)),
            Expanded(
              flex: 5,
              child: Text('Preço', style: textStyle, textAlign: TextAlign.center),
            ),
            Expanded(
              flex: 3,
              child: Text('24 H', style: textStyle, textAlign: TextAlign.end),
            ),
            Expanded(
              flex: 7,
              child: Text('Valor de mercado', style: textStyle, textAlign: TextAlign.end),
            ),
          ],
        ),
      );
    }

    Widget buildPriceChange(double percentage) {
      final bool isPositive = percentage >= 0;
      final Color color = isPositive ? Colors.green : Colors.red;
      final IconData icon = isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down;
      final String percentageString = '${percentage.toStringAsFixed(1)}%';

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(icon, color: color, size: 22),
          Text(
            percentageString,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      );
    }

    Widget buildCoinRow(TrendingCoinEntity coin) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(coin.marketCapRank.toString(), style: const TextStyle(color: Colors.white70, fontSize: 16)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Image.network(coin.image, width: 22, height: 22),
                  const SizedBox(width: 12),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(coin.symbol.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                formatCurrency(coin.currentPrice),
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Expanded(flex: 3, child: buildPriceChange(coin.priceChangePercentage24h)),
            Expanded(
              flex: 7,
              child: Text(
                formatMarketCap(coin.marketCap),
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(right: 8),
      itemCount: coins.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: buildHeader());
        }
        final coin = coins[index - 1];
        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CoinDetailsPage(id: coin.id))),
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: buildCoinRow(coin)),
        );
      },
    );
  }
}
