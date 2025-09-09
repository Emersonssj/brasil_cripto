import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_card_widget.dart';
import '../../domain/entities/coin_entity.dart';
import '../../../coin_details/presentation/pages/coin_details_page.dart';
import 'coin_values_preview/coin_values_preview_widget.dart';
import 'favorite_star_widget.dart';

class CoinSearchItemWidget extends StatelessWidget {
  const CoinSearchItemWidget({super.key, required this.coins});

  final List<CoinEntity> coins;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: CustomCardWidget(
        padding: EdgeInsetsGeometry.only(left: 12),
        child: Column(
          children: coins
              .map(
                (coin) => InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CoinDetailsPage(id: coin.id)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        Image.network(coin.large, height: 32, width: 32),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coin.symbol,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                coin.name,
                                style: const TextStyle(color: Colors.grey, fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        //CoinValuesPreviewWidget(id: coin.id),
                        FavoriteStarWidget(coin: coin),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
