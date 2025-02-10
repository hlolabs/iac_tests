# IaC Tests 🚀  
Repositório para testes e aprendizado de **Infrastructure as Code (IaC)** utilizando **Terraform, AWS EKS, Rancher e S3**.  

## 📌 Tecnologias Utilizadas  
- **Terraform**: Gerenciamento de infraestrutura como código.  
- **AWS EKS**: Orquestração de contêineres com Kubernetes.  
- **Rancher**: Gerenciamento e deploy de clusters Kubernetes.  
- **AWS S3**: Armazenamento de arquivos e backend para Terraform.  

## 🚀 Como Usar  

### 🔧 Pré-requisitos  
1. **Terraform** instalado ([Download](https://developer.hashicorp.com/terraform/downloads))  
2. **AWS CLI** configurado (`aws configure`)  
3. Permissões adequadas na AWS para provisionar EKS, S3 e recursos necessários  

### 🌱 Configuração Inicial  
1. Clone o repositório:  
   git clone https://github.com/hlolabs/iac_tests.git  
   cd iac_tests  
2. Configure as variáveis de ambiente:  
   export AWS_PROFILE=meu-perfil  
   export TF_VAR_region=us-east-1  
3. Inicialize o Terraform:  
   terraform init  

### ⚡ Criando Infraestrutura  
   terraform apply -auto-approve  

### 🔥 Destruindo Infraestrutura  
   terraform destroy -auto-approve  

## 📂 Estrutura de Pastas  
Aqui está a estrutura de pastas do repositório:

```
iac_tests/
├── backend/               # Configurações do backend S3 para Terraform
├── eks/                   # Módulo de provisionamento do EKS
├── s3/                    # Módulo para configuração de buckets S3
├── rancher/               # Configuração para integração com Rancher
├── terraform/             # Arquivos principais do Terraform
└── variables/             # Arquivos de variáveis e configurações
```

## 📖 Próximos Passos  
- [ ] Melhorar o módulo do EKS  
- [ ] Automatizar deploy com CI/CD  
- [ ] Adicionar políticas de segurança no S3  

---  

📌 **Autor:** [hlolabs](https://github.com/hlolabs)  
🚀 *Projeto em constante evolução!*

---