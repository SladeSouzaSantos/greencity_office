import 'area.dart';

class Volume extends Area{
  final double _altura;

  Volume({required super.comprimento, required super.largura, required double altura}) : _altura = altura;

  double get height => _altura;

  double getVolume(){
    return (getArea()*_altura);
  }
}