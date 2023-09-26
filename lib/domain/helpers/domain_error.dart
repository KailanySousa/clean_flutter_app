enum DomainError {
  unexpected,
  invalidCredencials,
}

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredencials:
        return 'Credenciais inválidas';
      default:
        return 'Algo errado aconteceu. Tente novamente em breve';
    }
  }
}
