import '../mensal/temperatura_mensal.dart';

class TemperaturaAnual {
  final List<TemperaturaMensal> _listaTemperaturaMaxima;
  final List<TemperaturaMensal> _listaTemperaturaMinima;
  final List<TemperaturaMensal> _listaTemperaturaMedia;

  TemperaturaAnual({
    required List<TemperaturaMensal> listaTemperaturaMaxima, required List<TemperaturaMensal> listaTemperaturaMinima,
    required List<TemperaturaMensal> listaTemperaturaMedia}) : _listaTemperaturaMaxima = listaTemperaturaMaxima,
        _listaTemperaturaMinima = listaTemperaturaMinima, _listaTemperaturaMedia = listaTemperaturaMedia;

  List<TemperaturaMensal> get listaTemperaturaMedia => _listaTemperaturaMedia;

  List<TemperaturaMensal> get listaTemperaturaMinima => _listaTemperaturaMinima;

  List<TemperaturaMensal> get listaTemperaturaMaxima => _listaTemperaturaMaxima;
}