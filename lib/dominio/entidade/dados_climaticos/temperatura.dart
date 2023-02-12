import '../dados_comuns/mes.dart';
import 'variavel_climatica.dart';

class Temperatura extends VariavelClimatica{
  Temperatura({required double valorGrausCelsius, Mes? mes}) : super(valor: valorGrausCelsius, mes: mes);
}