import '../dados_climaticos.dart';

class DadosClimaticosAnual{

  final List<TemperaturaAnual> _listaTemperaturaAnual;
  final List<UmidadeRelativaMensal> _listaUmidadeRelativa;
  final List<HoraSolarPico> _listaHoraSolarPico;

  DadosClimaticosAnual({
    required List<TemperaturaAnual> listaTemperaturaAnual, required List<UmidadeRelativaMensal> listaUmidadeRelativa,
    required List<HoraSolarPico> listaHoraSolarPico}) : _listaTemperaturaAnual = listaTemperaturaAnual,
        _listaUmidadeRelativa = listaUmidadeRelativa, _listaHoraSolarPico = listaHoraSolarPico;

  List<TemperaturaAnual> get listaTemperaturaAnual => _listaTemperaturaAnual;

  List<UmidadeRelativaMensal> get listaUmidadeRelativa => _listaUmidadeRelativa;

  List<HoraSolarPico> get listaHoraSolarPico => _listaHoraSolarPico;

}