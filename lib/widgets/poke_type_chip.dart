import 'package:flutter/material.dart';
import 'package:pokedex/helpers/poke_helper.dart';

class PokeTypeChip extends StatelessWidget {
  final String type;

  const PokeTypeChip({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      avatar: Text(
        PokeHelper.getIcon(type),
        style: TextStyle(
          fontFamily: 'PokeGoTypes',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      label: Text(
        type,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: PokeHelper.getColor(type),
    );
  }
}
