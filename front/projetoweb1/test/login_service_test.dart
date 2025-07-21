import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:projetoweb1/services/login_service.dart';
import 'login_service_test.mocks.dart';

@GenerateMocks([LoginService])
void main() {
  group('LoginService', () {
    late MockLoginService mockLoginService;

    setUp(() {
      mockLoginService = MockLoginService();
    });

    test('Deve retornar true para credenciais válidas', () async {
      when(mockLoginService.login("email@example.com", "senha123"))
          .thenAnswer((_) async => true);

      final result = await mockLoginService.login("email@example.com", "senha123");
      expect(result, true);
    });

    test('Deve retornar false para credenciais inválidas', () async {
      when(mockLoginService.login("email@errado.com", "senhaErrada"))
          .thenAnswer((_) async => false);

      final result = await mockLoginService.login("email@errado.com", "senhaErrada");
      expect(result, false);
    });
  });
}
