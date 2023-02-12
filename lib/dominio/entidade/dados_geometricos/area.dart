class Area{
  final double _comprimento;
  final double _largura;

  Area({required double comprimento, required double largura}) : _comprimento = comprimento, _largura = largura;

  double get comprimento => _comprimento;

  double get largura => _largura;

  double getArea(){
    return (_comprimento*_largura);
  }
}