# Site Estático com S3 usando Terraform

Este projeto utiliza Terraform para criar um site estático hospedado no Amazon S3.

## 📌 Pré-requisitos

Antes de começar, certifique-se de ter as seguintes ferramentas instaladas:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)

## ⚙️ Configuração

### 1️⃣ Configurar AWS CLI
Configure o AWS CLI com suas credenciais:
```sh
aws configure
```

### 2️⃣ Inicializar o Terraform
Inicialize o Terraform para baixar os provedores necessários:
```sh
terraform init
```

### 3️⃣ Revisar o Plano de Execução
Revise o plano de execução para entender as mudanças que serão feitas na sua infraestrutura:
```sh
terraform plan
```

### 4️⃣ Aplicar a Configuração
Aplique a configuração para criar os recursos na AWS:
```sh
terraform apply
```

### 5️⃣ Acessar o Site
Após a aplicação do Terraform, o URL do site estará disponível na saída. Você pode acessar o site pelo URL fornecido.

## 🧹 Limpeza

Para destruir todos os recursos criados pelo Terraform, execute:
```sh
terraform destroy
```

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir um issue ou enviar um pull request.

## 📜 Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🎉 Créditos

Este projeto foi desenvolvido com a ajuda do GenAI Platform.

