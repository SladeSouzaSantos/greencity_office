import '../dates_data/mes.dart';
import 'variavel_climatica.dart';

class UmidadeRelativa extends VariavelClimatica{
  UmidadeRelativa({Mes? mes, required double valorPercentagem}) : super(valor: valorPercentagem, mes: mes);
}