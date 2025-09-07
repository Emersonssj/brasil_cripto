import 'package:flutter/material.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = {
      'Valor de mercado': 2226651219589,
      'Fornecimento circulante': '19,9 milhões',
      'Avaliação totalmente diluída': 2226651219589,
      'Fornecimento total': '19,9 milhões',
      'Cap. de Mercado/Relação FDV': 1,
      'Suprimento Máximo': '21,0 milhões',
      'Volume de negócios': 28274348819,
      'Adicionada à Lista de Observação': 2169885,
    };
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('teste', style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              'teste',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
