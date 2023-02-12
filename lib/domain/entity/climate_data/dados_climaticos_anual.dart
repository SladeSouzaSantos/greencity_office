import 'climate_data.dart';

class DadosClimaticosAnual{

  final List<TemperaturaAnual> _listaTemperaturaAnual;
  final List<UmidadeRelativa> _listaUmidadeRelativa;
  final List<HoraSolarPico> _listaHoraSolarPico;

  DadosClimaticosAnual({
    required List<TemperaturaAnual> listaTemperaturaAnual, required List<UmidadeRelativa> listaUmidadeRelativa,
    required List<HoraSolarPico> listaHoraSolarPico}) : _listaTemperaturaAnual = listaTemperaturaAnual,
        _listaUmidadeRelativa = listaUmidadeRelativa, _listaHoraSolarPico = listaHoraSolarPico;

  List<TemperaturaAnual> get listaTemperaturaAnual => _listaTemperaturaAnual;

  List<UmidadeRelativa> get listaUmidadeRelativa => _listaUmidadeRelativa;

  List<HoraSolarPico> get listaHoraSolarPico => _listaHoraSolarPico;

  double calcularMediaAnualVariavelClimatica({required List<VariavelClimatica> listaVariavelClimatica}){
    double somaValorVariavelClimatica = 0;

    for (var variavelClimatica in listaVariavelClimatica) {
      somaValorVariavelClimatica += variavelClimatica.valor;
    }

    double valorMedioVariavelClimatica = somaValorVariavelClimatica/listaVariavelClimatica.length;

    return valorMedioVariavelClimatica;
  }

  double calcularMenorValorAnual({required List<VariavelClimatica> listaVariavelClimatica}){
    return listaVariavelClimatica.reduce((variavelClimaticaReferencia, variavelClimaticaProximo) =>
    variavelClimaticaReferencia.valor < variavelClimaticaProximo.valor ?
    variavelClimaticaReferencia : variavelClimaticaProximo).valor;
  }

  double calcularMaiorValorAnual({required List<VariavelClimatica> listaVariavelClimatica}){
    return listaVariavelClimatica.reduce((variavelClimaticaReferencia, variavelClimaticaProximo) =>
    variavelClimaticaReferencia.valor > variavelClimaticaProximo.valor ?
    variavelClimaticaReferencia : variavelClimaticaProximo).valor;
  }

}