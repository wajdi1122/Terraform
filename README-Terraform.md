# Terraform: ecs-FARGATE/vpc/alb/rds

This repository contains Terraform configurations for deploying a robust infrastructure on AWS, including an ECS Fargate cluster, VPC, Application Load Balancer (ALB), and RDS database. It leverages Docker for containerization of both frontend and backend components.

## Key Features & Benefits

*   **Infrastructure as Code (IaC):** Automates infrastructure provisioning and management using Terraform.
*   **ECS Fargate:** Deploys containerized applications without managing servers.
*   **VPC:** Creates a secure and isolated network environment for your resources.
*   **ALB:** Provides intelligent traffic routing and load balancing for your applications.
*   **RDS:** Sets up a scalable and managed relational database service.
*   **Dockerized Applications:**  Supports containerized applications using Docker.
*   **CI/CD Pipeline:** Implements a basic CI/CD pipeline using GitHub Actions.

## Prerequisites & Dependencies

*   [Terraform](https://www.terraform.io/downloads) (>= 1.0)
*   [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
*   [Docker](https://www.docker.com/)
*   Java Development Kit (JDK) 17
*   Node.js and npm (for building the frontend, if necessary)

## Installation & Setup Instructions

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/wajdi1122/Terraform.git
    cd Terraform
    ```

2.  **Configure AWS Credentials:**

    Ensure you have configured your AWS credentials using the AWS CLI.

    ```bash
    aws configure
    ```

3.  **Initialize Terraform:**

    ```bash
    cd aws
    terraform init -backend-config="backend.tf"
    ```

    **Note:**  Ensure that your `backend.tf` file points to a valid S3 bucket and DynamoDB table for Terraform state management.  Replace `<YOUR_S3_BUCKET>` and `<YOUR_DYNAMODB_TABLE>` with your actual bucket and table names:

    ```terraform
    terraform {
      backend "s3" {
        bucket         = "<YOUR_S3_BUCKET>"
        key            = "terraform/state"
        region         = "your-aws-region" #e.g., us-east-1
        dynamodb_table = "<YOUR_DYNAMODB_TABLE>"
        encrypt        = true
      }
    }
    ```

4.  **Plan the Infrastructure:**

    ```bash
    terraform plan
    ```

5.  **Apply the Configuration:**

    ```bash
    terraform apply
    ```

    Type `yes` when prompted to confirm the deployment.

6. **Build and Push Docker images:**

   Navigate to the `docker/back-end` and `docker/front-end` directories and build and push docker images to your preferred registry (e.g., Docker Hub, AWS ECR)
   ```bash
   cd docker/back-end
   docker build -t your-dockerhub-username/back-end:latest .
   docker push your-dockerhub-username/back-end:latest

   cd ../front-end
   docker build -t your-dockerhub-username/front-end:latest .
   docker push your-dockerhub-username/front-end:latest
   ```
   Remember to update the ECS task definition with the correct image URIs.

## Usage Examples & API Documentation

### Accessing the Application

After the Terraform deployment completes successfully, you can access your application through the ALB's DNS name, which is outputted by Terraform.

### Example Output

```
Outputs:

alb_dns_name = "your-alb-dns-name.elb.amazonaws.com"
```

You can then navigate to this DNS name in your web browser to access the application.

## Configuration Options

### Variables

The Terraform modules utilize variables that can be configured to customize your infrastructure. These variables are defined in the `variables.tf` files within each module (`alb`, `ecs`, `rds`, `vpc`).

### Example: VPC Module Variables

```terraform
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}
```

You can override the default values of these variables by:

*   Setting environment variables with the prefix `TF_VAR_` (e.g., `TF_VAR_vpc_cidr="192.168.0.0/16"`).
*   Providing a `terraform.tfvars` file with the variable values.
*   Passing the variable values directly on the command line using the `-var` flag (e.g., `terraform apply -var="vpc_cidr=192.168.0.0/16"`).

## Project Structure

```
├── .gitignore
└── aws/
    ├── backend.tf                 # Terraform backend configuration
    ├── ci-cd/
    │   └── github-actions.yml     # GitHub Actions CI/CD workflow
    ├── main.tf                    # Main Terraform configuration file
    └── modules/                   # Reusable Terraform modules
        ├── alb/                     # Application Load Balancer module
        │   ├── main.tf            # ALB resources
        │   ├── outputs.tf         # ALB outputs
        │   └── variables.tf       # ALB variables
        ├── ecs/                     # ECS Fargate module
        │   ├── main.tf            # ECS resources
        │   ├── outputs.tf         # ECS outputs
        │   └── variables.tf       # ECS variables
        ├── rds/                     # RDS module
        │   ├── main.tf            # RDS resources
        │   ├── outputs.tf         # RDS outputs
        │   └── variables.tf       # RDS variables
        └── vpc/                     # VPC module
            ├── main.tf            # VPC resources
            ├── outputs.tf         # VPC outputs
            └── variables.tf       # VPC variables
```

## Important Files

### `docker/back-end/Dockerfile`

```dockerfile
# Utilise une image de base avec Java 17
FROM eclipse-temurin:17-jdk-jammy

# Définit le répertoire de travail dans le conteneur
WORKDIR /app

# Copie le fichier JAR de l'application dans le conteneur
COPY target/back-end-0.0.1-SNAPSHOT.jar app.jar

# Expose le port sur lequel l'application Spring Boot écoute
EXPOSE 8080

# Commande pour exécuter l'application
ENTRYPOINT ["java", "-jar", "app.jar"]
```

### `docker/front-end/Dockerfile`

```dockerfile
FROM nginx:alpine

COPY . /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### `docker/front-end/index.html`

```html
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Employés</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Gestion des Employés</h1>

    <!-- Formulaire pour ajouter/modifier un employé -->
    <form id="employeeForm">
        <input type="hidden" id="employeeId" name="id">
        <label for="name">Nom:</label>
        <input type="text" id="name" name="name"...
```

### `docker/front-end/script.js`

```js
const API_URL = "http://localhost:8080/api/employees";

// Récupérer les éléments du DOM
const employeeForm = document.getElementById("employeeForm");
const employeeTable = document.getElementById("employeeTable").getElementsByTagName("tbody")[0];
const submitButton = document.getElementById("submitButton");

// Fonction pour charger et afficher les employés
async function loadEmployees() {
    const response = await fetch(API_URL);
    const employees = await response.json();

    employeeTable...
```

### `docker/front-end/styles.css`

```css
body {
    font-family: Arial, sans-serif;
    margin: 20px;
}

h1, h2 {
    color: #333;
}

form {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-top: 10px;
}

input {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
    margin-bottom: 10px;
    box-sizing: border-box;
}

button {
    padding: 10px 20px;
    background-color: #28a745;
    color: white;
    border: none;
    cursor: pointer;
}

button:hover {
    background-color: #218838;
}

table {
    width: 100%;
 ...
```

## Contributing Guidelines

We welcome contributions to this project! To contribute, please follow these steps:

1.  Fork the repository.
2.  Create a new branch for your feature or bug fix.
3.  Make your changes and commit them with descriptive commit messages.
4.  Submit a pull request.

## License Information

License is not specified. Please contact the owner for more information.

## Acknowledgments

*   Terraform: [https://www.terraform.io/](https://www.terraform.io/)
*   AWS: [https://aws.amazon.com/](https://aws.amazon.com/)
*   Docker: [https://www.docker.com/](https://www.docker.com/)