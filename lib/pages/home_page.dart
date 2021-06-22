import 'package:flutter/material.dart';
import 'package:infinite_widgets/infinite_widgets.dart';
import 'package:pokedex/controllers/home_controller.dart';
import 'package:pokedex/core/app_const.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/pages/detail_page.dart';
import 'package:pokedex/repositories/poke_repository_impl.dart';
import 'package:pokedex/widgets/poke_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController(PokeRepositoryImpl());
  bool searchBar = false;
  List<PokemonModel> pokemons = [];
  List<PokemonModel> filteredPokemons = [];

  getPokemons() async {
    var data = await _controller.fetch();
    return data;
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future<void> _initialize() async {
    await _controller.fetch();
    getPokemons().then((data) {
      setState(() {
        pokemons = filteredPokemons = data;
      });
    });
    //setState(() {
    //});
  }

  void _filterPokemon(String name) {
    setState(() {
      filteredPokemons = _controller.pokemons
          .where(
              (value) => value.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: filteredPokemons.length > 0
          ? Container(
            height: 250.0,
            width: 250.0, 
            child: PokemonCard(
              pokemon: filteredPokemons.first,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      pokemon: filteredPokemons.first,
                    ),
                  ),
                );
              },
            ),
          )
          : InfiniteGridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: _buildCard,
              itemCount: _controller.length,
              hasNext: _controller.length < 1118,
              nextData: _onNext,
            ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: !searchBar
          ? _buildText()
          : TextFormField(
              onChanged: (value) {
                _filterPokemon(value);
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.black),
                hintText: 'Buscar pokemon',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
      actions: <Widget>[
        searchBar
            ? IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  setState(() {
                    this.searchBar = false;
                    filteredPokemons = pokemons;
                  });
                },
              )
            : IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  setState(() {
                    this.searchBar = true;
                  });
                },
              )
      ],
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  _buildText() {
    return Text(kAppTitle,
        style: TextStyle(color: Colors.black, fontFamily: 'Pokemon'));
  }

  Future<void> _onNext() async {
    await _controller.next();
    setState(() {});
  }

  Widget _buildCard(BuildContext context, int index) {
    final pokemon = _controller.pokemons[index];
    return PokemonCard(
      pokemon: pokemon,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(
              pokemon: pokemon,
            ),
          ),
        );
      },
    );
  }
}
