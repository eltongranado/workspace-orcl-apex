# Repositório de Pipeline

Este repositório contém scripts e definições para pipelines usados no processo de integração contínua (CI/CD).

## Parâmetros do Arquivo `config-deploy.json`

### Abertura de Feature Branch

```bash
git clone https://ambientalcorp@dev.azure.com/ambientalcorp/Eng.%20de%20Plataforma%20e%20Aplica%C3%A7%C3%B5es/_git/workspace-apps
git checkout develop            # Mudar para a branch develop
git pull origin develop         # Atualizar a branch develop
git checkout -b feature/xpto    # Criar e mudar para a nova feature branch
```

### 1. Configuração para Aplicações Oracle APEX

O bloco `apex` contém configurações relacionadas às aplicações Oracle APEX.

```json
{
  "apex": [
    {
      "appids": [102],
      "pageids": [1, 2]
    }
  ]
}
```
* appids: Uma lista de IDs de aplicações Oracle APEX a serem processados.
* pageids: Uma lista de IDs de páginas associadas às aplicações especificadas.

### 2. Configuração para Scripts de Banco de Dados Oracle

O bloco database contém configurações relacionadas aos scripts a serem executados no banco de dados Oracle.

```json

{
  "database": {
    "scripts": [
      {"ordem": 1, "script": "script-1.sql"}
    ]
  }
}
```

* scripts: Uma lista de objetos, onde cada objeto contém:
* ordem: A ordem de execução do script.
script: O nome do script SQL a ser executado.

### 3. Como Utilizar

Clone este repositório em seu ambiente local.
Atualize o arquivo config-deploy.json com as configurações específicas do seu projeto.
Execute o pipeline para iniciar o processo de CI/CD.

Lembre-se de manter este README atualizado conforme novas configurações de pipeline são adicionadas ou alterações significativas são feitas no arquivo config-deploy.json.

É necessário criar uma library no Azure DevOps para armazenar o token.