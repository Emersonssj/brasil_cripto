import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/dependency_injection.dart';
import '../blocs/coin_search_bloc.dart';
import '../blocs/coin_search_event.dart';
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

  void _onSearchChanged(String query) {
    setState(() {
      if (query != '') _coinSearchBloc.add(GetCoinsEvent(query));
    });
  }

  void _clearSearchField() {
    setState(() {
      _searchController.clear();
      _coinSearchBloc.add(ClearListEvent());
    });
  }

  @override
  void initState() {
    _coinSearchBloc = getDependency<CoinSearchBloc>();
    _coinSearchBloc.add(ClearListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: TextField(
          onChanged: _onSearchChanged,
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
                    onPressed: _clearSearchField,
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
              return Center(child: Text('Nenhuma criptomoeda encontrada'));
            } else {
              return Visibility(
                visible: _searchController.text != '',
                replacement: SizedBox(),
                child: CoinSearchItemWidget(coins: state.coins),
              );
            }
          }

          if (state is GetCoinsErrorState) {
            return Center(child: Text('Erro: ${state.exception.userMessage}'));
          }

          return SizedBox();
        },
      ),
    );
  }
}
