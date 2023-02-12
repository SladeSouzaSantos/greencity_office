import '../../dados_calendario/mes.dart';
import 'variavel_climatica_mensal.dart';

class TemperaturaMensal extends VariavelClimaticaMensal{
  TemperaturaMensal({required double valorGrausCelsius, required Mes mes}) : super(valor: valorGrausCelsius, mes: mes);
}