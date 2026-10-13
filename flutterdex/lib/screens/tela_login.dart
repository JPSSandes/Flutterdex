import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/navegacao.dart';
import '../services/sessao.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  String? _erro;

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _tentarEntrar() {
    final ok = context.read<Sessao>().entrar(
      _usuarioController.text,
      _senhaController.text,
    );

    if (ok) {
      context.read<Navegacao>().voltar();
    } else {
      setState(() {
        _erro = 'Usuário ou senha incorretos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.read<Navegacao>().voltar(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.catching_pokemon,
              size: 96,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _usuarioController,
              decoration: const InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              obscureText: true, // esconde o que é digitado
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _tentarEntrar(),
            ),
            if (_erro != null) ...[
              const SizedBox(height: 12),
              Text(
                _erro!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _tentarEntrar,
                child: const Text('Entrar'),
              ),
            ),
            TextButton(
              onPressed: () => context.read<Navegacao>().voltar(),
              child: const Text('Continuar sem login'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Dados fictícios: ash / pikachu123',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
