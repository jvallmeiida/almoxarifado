# Aplicativo sistema de Almoxarifado

A aplicação contempla:
- CRUD de Produtos(materiais)
- Sistema de login usuário(email, senha)
- Funciona somente em horário comercial retirada de produtos
- Produto só pode ser apagado se não tiver movimentações de estoque

O que eu gostaria de implementar:
- Datatable
- Botão para desativar o usuário

#### Tecnologias usadas:

- Rails 5.2.7
- Ruby 2.6.1
- BootStrap 5.0
- Devise
- Mysql

#### Como rodar a aplicação:

- Primeiramente clone a aplicação
- Certifique-se se as versões da aplicação estão instaladas em seu computador
- Rode *rails db:create* / *rails db:migrate*
      ou use *mysql -uroot* para criar seu banco
- Rode *bundle install*
- Iniciei a aplicação com *rails server*
