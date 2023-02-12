import '../../dados_calendario/mes.dart';
import 'variavel_climatica_mensal.dart';

class UmidadeRelativaMensal extends VariavelClimaticaMensal{
  UmidadeRelativaMensal({required Mes mes, required double valorPercentagem}) : super(valor: valorPercentagem, mes: mes);
}