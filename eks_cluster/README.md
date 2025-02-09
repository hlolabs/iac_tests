# Projeto EKS com Terraform e Nginx

Este projeto utiliza Terraform para criar um cluster EKS na AWS e implanta um pod Nginx com um site simples para teste.

## 📌 Pré-requisitos

Antes de começar, certifique-se de ter as seguintes ferramentas instaladas:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

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

### 5️⃣ Configurar kubectl
Configure o `kubectl` para usar o novo cluster EKS:
```sh
aws eks update-kubeconfig --name eks-cluster
```

### 6️⃣ Aplicar Configurações do Kubernetes
Aplique as configurações do Kubernetes para criar o pod Nginx:
```sh
kubectl apply -f config_map.yaml
```

## 📂 Estrutura do Projeto

O projeto está estruturado da seguinte forma:

```
📦 projeto-eks
├── provider.tf          # Configuração dos provedores AWS e Kubernetes
├── vpc.tf               # Configuração da VPC, subnets e gateway
├── eks.tf               # Configuração do cluster EKS e do grupo de nós
├── launch_template.tf   # Configuração do template de lançamento para os nós do EKS
├── outputs.tf           # Saídas do Terraform
├── config_map.yaml      # Configuração do pod Nginx com um site simples
├── user_data.sh         # Script de inicialização para os nós (se necessário)
└── README.md            # Documentação do projeto
```

## 🌐 Conteúdo do Site

O site simples exibido pelo Nginx contém a seguinte mensagem:

```html
<html>
<head>
  <title>Site do Helder</title>
</head>
<body>
  <h1>Site do Helder em IaC com ajuda do GenAI Platform</h1>
</body>
</html>
```

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

Este projeto foi desenvolvido com a ajuda da IA (hehehe).

