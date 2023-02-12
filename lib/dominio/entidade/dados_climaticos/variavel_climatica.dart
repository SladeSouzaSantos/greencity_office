import '../dados_comuns/mes.dart';

abstract class VariavelClimatica{
  final double _valor;
  final Mes? _mes;

  VariavelClimatica({Mes? mes, required double valor}) : _mes = mes, _valor = valor;

  double get valor => _valor;

  Mes? get mes => _mes;
}