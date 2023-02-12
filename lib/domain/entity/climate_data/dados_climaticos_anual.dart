import 'temperatura.dart';
import 'umidade_relativa.dart';
import 'variavel_climatica.dart';

class DadosClimaticosAnual{

  final List<Temperatura> _listaTemperaturaMaxima, _listaTemperaturaMinima, _listaTemperaturaMedia;
  final List<UmidadeRelativa> _listaUmidadeRelativa;

  DadosClimaticosAnual({
        required List<Temperatura> listaTemperaturaMaxima, required List<Temperatura> listaTemperaturaMinima,
        required List<Temperatura> listaTemperaturaMedia, required List<UmidadeRelativa> listaUmidadeRelativa})
      : _listaTemperaturaMaxima = listaTemperaturaMaxima, _listaTemperaturaMinima = listaTemperaturaMinima,
        _listaTemperaturaMedia = listaTemperaturaMedia, _listaUmidadeRelativa = listaUmidadeRelativa;

  List<Temperatura> get listaTemperaturaMaxima => _listaTemperaturaMaxima;

  List<Temperatura> get listaTemperaturaMinima => _listaTemperaturaMinima;

  List<Temperatura> get listaTemperaturaMedia => _listaTemperaturaMedia;

  List<UmidadeRelativa> get listaUmidadeRelativa => _listaUmidadeRelativa;

  double get valorMedioTemperaturaMaxima => _valorMedioVariavelClimatica(_listaTemperaturaMaxima);

  double get valorMedioTemperaturaMinima => _valorMedioVariavelClimatica(_listaTemperaturaMinima);

  double get valorMedioTemperaturaMedia => _valorMedioVariavelClimatica(_listaTemperaturaMedia);

  double get valorMedioUmidadeRelativa => _valorMedioVariavelClimatica(_listaUmidadeRelativa);

  double _valorMedioVariavelClimatica(List<VariavelClimatica> listaVariavelClimatica){
    double somaValorVariavelClimatica = 0;

    for (var temperatura in listaVariavelClimatica) {
      somaValorVariavelClimatica += temperatura.valor;
    }

    double valorMedioVariavelClimatica = somaValorVariavelClimatica/listaVariavelClimatica.length;

    return valorMedioVariavelClimatica;
  }

}