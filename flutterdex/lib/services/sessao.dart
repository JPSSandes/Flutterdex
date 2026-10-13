import 'package:flutter/foundation.dart';

class Sessao extends ChangeNotifier {
  static const String _usuarioValido = 'ash';
  static const String _senhaValida = 'pikachu123';

  String? _usuario;
  bool _temaEscuro = false;
  bool _apenasFavoritos = false;

  final Set<int> _favoritos = {};

  bool get logado => _usuario != null;
  String? get usuario => _usuario;
  bool get temaEscuro => _temaEscuro;
  int get totalFavoritos => _favoritos.length;
  bool get apenasFavoritos => _apenasFavoritos;

  bool ehFavorito(int id) {
    return _favoritos.contains(id);
  }

  bool entrar(String usuario, String senha) {
    if (usuario.trim() == _usuarioValido && senha == _senhaValida) {
      _usuario = _usuarioValido;
      notifyListeners(); // avisa as telas que o estado mudou
      return true;
    }
    return false;
  }

  void sair() {
    _usuario = null;
    _temaEscuro = false;
    _apenasFavoritos = false;
    notifyListeners();
  }

  void alternarFavorito(int id) {
    if (!logado) return;

    if (_favoritos.contains(id)) {
      _favoritos.remove(id);
    } else {
      _favoritos.add(id);
    }
    notifyListeners();
  }

  void alternarFiltroFavoritos() {
    if (!logado) return;

    _apenasFavoritos = !_apenasFavoritos;
    notifyListeners();
  }

  void alternarTema() {
    if (!logado) return;

    _temaEscuro = !_temaEscuro;
    notifyListeners();
  }
}
