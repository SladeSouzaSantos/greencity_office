import '../../entidade/dados_climaticos/dados_climaticos.dart';

class CalcularValoresClimaticosAnuais{

  double calcularMediaAnualVariavelClimatica({required List<VariavelClimatica> listaVariavelClimatica}){
    double somaValorVariavelClimatica = 0;

    for (var variavelClimatica in listaVariavelClimatica) {
      somaValorVariavelClimatica += variavelClimatica.valor;
    }

    double valorMedioVariavelClimatica = somaValorVariavelClimatica/listaVariavelClimatica.length;

    return valorMedioVariavelClimatica;
  }

  VariavelClimatica calcularMenorValorAnual({required List<VariavelClimatica> listaVariavelClimatica}){
    return listaVariavelClimatica.reduce((variavelClimaticaReferencia, variavelClimaticaProximo) =>
    variavelClimaticaReferencia.valor < variavelClimaticaProximo.valor ?
    variavelClimaticaReferencia : variavelClimaticaProximo);
  }

  VariavelClimatica calcularMaiorValorAnual({required List<VariavelClimatica> listaVariavelClimatica}){
    return listaVariavelClimatica.reduce((variavelClimaticaReferencia, variavelClimaticaProximo) =>
    variavelClimaticaReferencia.valor > variavelClimaticaProximo.valor ?
    variavelClimaticaReferencia : variavelClimaticaProximo);
  }

}