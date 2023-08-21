Feature: Login
Como um cliente
Quero poder acessar minha conta e me manter logado
Para que eu possa ver e responder enquestes de forma rápida

Scenario: Credencias Válidas
Given que o cliente informou credenciais VálidasQuando solicitar para fazer Login
Then o sistem deve enviar o usuário para a tela de pesqusas
And manter o usuário conectado

Scenario: Credenciais Inválidas
Given que o cliente informou credenciais Inválidas
When solicitar para fazer Login
Then o sistema deve retornar uma mensagem de erro