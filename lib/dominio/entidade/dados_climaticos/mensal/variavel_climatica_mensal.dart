import '../../dados_calendario/mes.dart';
import '../base/variavel_climatica.dart';

abstract class VariavelClimaticaMensal extends VariavelClimatica{
  final Mes _mes;

  VariavelClimaticaMensal({required super.valor ,required Mes mes}) : _mes = mes;

  Mes get mes => _mes;
}