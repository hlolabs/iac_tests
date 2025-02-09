#!/bin/bash

# Lista de arquivos com numeração
files=(
  "01-provider.tf"
  "02-s3.tf"
  "03-outputs.tf"
  "04-index.html"
  "05-README.md"
)

# Criar os arquivos
for file in "${files[@]}"; do
  touch "$file"
  echo "Arquivo criado: $file"
done

echo "Todos os arquivos foram criados com sucesso!"
