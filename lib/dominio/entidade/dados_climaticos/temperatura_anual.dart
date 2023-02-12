import 'temperatura.dart';

class TemperaturaAnual {
  final List<Temperatura> _listaTemperaturaMaxima;
  final List<Temperatura> _listaTemperaturaMinima;
  final List<Temperatura> _listaTemperaturaMedia;

  TemperaturaAnual({
    required List<Temperatura> listaTemperaturaMaxima, required List<Temperatura> listaTemperaturaMinima,
    required List<Temperatura> listaTemperaturaMedia}) : _listaTemperaturaMaxima = listaTemperaturaMaxima,
        _listaTemperaturaMinima = listaTemperaturaMinima, _listaTemperaturaMedia = listaTemperaturaMedia;

  List<Temperatura> get listaTemperaturaMedia => _listaTemperaturaMedia;

  List<Temperatura> get listaTemperaturaMinima => _listaTemperaturaMinima;

  List<Temperatura> get listaTemperaturaMaxima => _listaTemperaturaMaxima;
}