Feature: Login
Como um cliente
Quero poder acessar minha conta e me manter logado
Para que eu possa ver e responder enquestes de forma rápida

Cenário: Credencias Válidas
Dado que o cliente informou credenciais VálidasQuando solicitar para fazer Login
Então o sistem deve enviar o usuário para a tela de pesqusas
E manter o usuário conectado

Cenário: Credenciais Inválidas
Dado que o cliente informou credenciais Inválidas
Quando solicitar para fazer Login
Então o sistema deve retornar uma mensagem de erro