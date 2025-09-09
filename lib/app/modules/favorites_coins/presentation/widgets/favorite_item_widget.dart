import 'package:flutter/material.dart';

import '../../../coin_details/presentation/pages/coin_details_page.dart';
import '../../../coin_search/domain/entities/coin_entity.dart';

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({super.key, required this.coin, required this.onDeletePressed});

  final CoinEntity coin;
  final void Function(BuildContext context, String id) onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CoinDetailsPage(id: coin.id))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Image.network(coin.large, width: 32, height: 32),
            SizedBox(width: 8),
            Text(coin.name),
            Expanded(child: SizedBox()),
            IconButton(
              onPressed: () => onDeletePressed(context, coin.id),
              icon: Icon(Icons.delete, color: Colors.red, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
