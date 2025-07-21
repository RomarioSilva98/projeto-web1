import 'package:flutter/material.dart';
import 'views/login_page.dart';
import 'views/detalhes_banda_page.dart';
import 'views/detalhes_repertorio_page.dart';
import 'models/banda.dart';
import 'models/repertorio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SongFlow',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/login', // Rota inicial
      routes: {
        '/login': (context) => LoginPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/banda') {
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => DetalhesBandaPage(
              banda: args['banda'] as Banda,
              usuarioId: args['usuarioId'] as int,
            ),
          );
        } else if (settings.name == '/repertorio') {
          final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => DetalhesRepertorioPage(
              repertorio: args['repertorio'] as Repertorio,
              idBanda: args['idBanda'] as int,
              usuarioId: args['usuarioId'] as int,
              responsavelId: args['responsavelId'] as int,
            ),
          );
        }
        return null; // Retorna null se a rota não for encontrada
      },
    );
  }
}
