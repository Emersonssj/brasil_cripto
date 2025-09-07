import 'package:brasil_cripto/app/modules/coin_search/presentation/blocs/coin_search_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/dependency_injection.dart';
import '../blocs/coin_search_bloc.dart';
import '../blocs/coin_search_state.dart';
import '../widgets/coin_search_items_widget.dart';

class CoinSearchPage extends StatefulWidget {
  const CoinSearchPage({super.key});

  @override
  State<CoinSearchPage> createState() => _CoinSearchPageState();
}

class _CoinSearchPageState extends State<CoinSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late final CoinSearchBloc _coinSearchBloc;

  @override
  void initState() {
    _coinSearchBloc = getDependency<CoinSearchBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: TextField(
          onChanged: (value) {
            setState(() {
              if (value != '') _coinSearchBloc.add(GetCoinsEvent(value));
            });
          },
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Pesquisar moeda',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: _searchController.text == ''
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<CoinSearchBloc, CoinSearchState>(
        bloc: _coinSearchBloc,
        builder: (context, state) {
          if (state is CoinSearchLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is GetCoinsSuccessState) {
            if (state.coins.isEmpty) {
              return Center(child: Text('Não foram encontradas moedas'));
            } else {
              return Visibility(
                visible: _searchController.text != '',
                replacement: SizedBox(),
                child: CoinSearchItemWidget(coins: state.coins),
              );
            }
          }

          return SizedBox();
        },
      ),
    );
  }
}
