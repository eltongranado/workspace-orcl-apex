#!/bin/bash

# Atribui os parâmetros a variáveis
PatToken=$1
BuildSourceBranch=$2
BuildRepositoryID=$3
SystemTeamProject=$4
SystemCollectionUri=$5
SystemTeamProjectId=$6

# Codifica o nome do projeto
TeamProjectEncode=$(printf "%s" "$SystemTeamProject" | sed 's/ /%20/g')

api="/_apis/git/repositories/$BuildRepositoryID/pullrequests?api-version=7.0"

# Constrói a URL da API
uri="$SystemCollectionUri$SystemTeamProjectId$api"

# Debug - Exibe informações
#echo "Token de Acesso Pessoal (PAT): $PatToken"
#echo "Branch de Origem: $BuildSourceBranch"
#echo "ID do Repositório: $BuildRepositoryID"
#echo "Nome do Projeto: $SystemTeamProject"
#echo "Nome do Projeto Tratado: $TeamProjectEncode"
#echo "URI: $uri"

# Constrói o corpo da requisição
body=$(jq -n --arg sourceRefName "$BuildSourceBranch" --arg targetRefName "refs/heads/master" --arg title "Pull Request branch $BuildSourceBranch" '{ "sourceRefName": $sourceRefName, "targetRefName": $targetRefName, "title": $title }')

# Constrói os cabeçalhos da requisição
headers=(-H "Authorization: Basic $(echo -n :$PatToken | base64)" -H "Content-Type: application/json")

# Exibe o comando curl que será executado
echo "Comando curl que será executado:"
echo "curl -s -L -X POST ${headers[@]} -d '$body' $uri"

# Realiza a chamada da API usando curl
response=$(curl -s -L -X POST "${headers[@]}" -d "$body" $uri)

# Exibe a resposta da API
echo "Resposta da API:"
echo $response
