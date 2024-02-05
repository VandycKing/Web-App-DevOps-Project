# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)

### Usage
To run the application, you first need to containerize it. You can do this by using the following command to build an image of the app:

```bash
docker build -t <name-of-the-image> .
```
This command creates a Docker image with the specified name (<name-of-the-image>) using the current directory as the build context. Once the image is built, you can run the app in a container with the following command:
```bash
docker run -p 5000:5000 <name of the image>
``` 
This command starts a Docker container based on the previously built image, mapping port 5000 on your local machine to port 5000 in the container. Once the container starts you should be able to access the application locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

### Azure Kubernetes Service (AKS) Deployment with Terraform

This project leverages Terraform, an open-source infrastructure as code software tool, for deploying a scalable and secure Azure Kubernetes Service (AKS) cluster, along with the necessary networking infrastructure within Microsoft Azure. Embracing a modular approach, the project is organized for enhanced reusability and clarity, ensuring a smooth and efficient infrastructure provisioning process.

#### Project Structure

- `aks-terraform/`
  - `main.tf`: This is the primary Terraform configuration file that orchestrates the integration of both the AKS and networking modules.
  - `variables.tf`: A file that defines the input variables used across the Terraform configuration, enabling customization and flexibility.
  - `staging.tfvars`, `dev.tfvars`, `prod.tfvars`, `default.tfvars`: These files contain environment-specific variables and secrets, allowing for distinct configurations for different deployment environments.
  - `aks-cluster-module/`: This directory houses the Terraform module for the AKS cluster setup.
    - `main.tf`: The main configuration file for the AKS module.
    - `variables.tf`: Defines input variables specific to the AKS module.
    - `outputs.tf`: Contains the output variables from the AKS module.
  - `networking-module/`: Contains the Terraform module for setting up networking.
    - `main.tf`: The main configuration file for the networking module.
    - `variables.tf`: Defines input variables for the networking module.
    - `outputs.tf`: Contains the output variables from the networking module, which are utilized in the AKS cluster module.
- `.gitignore`: Prevents tracking of certain files (like Terraform state files) in Git.

#### Project Initialization and Deployment

After setting up the project structure, initialize the Terraform environment within the `networking-module`, `aks-cluster-module`, and `aks-terraform` directories by running:

```bash
terraform init
```
To deploy the AKS infrastructure to Azure, execute the following command, replacing staging.tfvars with the appropriate environment-specific variable file:

```bash
terraform apply -var-file="staging.tfvars"
```

### Deploying Flask App to AKS with Kubernetes

To deploy the containerized Flask application to the provisioned AKS cluster, kubernetes manifest for deployment and service were prepared following the steps below:

#### Deployment and Service Manifests

##### Deployment Manifest

`flask-app-deployment` is our deployment configuration, managing the application's lifecycle:

- **Replicas**: Set to `2` for ensuring high availability.
- **Labels**: Uses `app: flask-app` for easy identification of pods.
- **Container Configuration**: Refers to our Flask app's Docker Hub image, exposing port `5000`.
- **Deployment Strategy**: Employs Rolling Updates to reduce downtime.

##### Service Manifest

`flask-app-service` is our Kubernetes Service for internal cluster communications:

- **Selector**: Matches the labels of pods from our Deployment.
- **Ports**: Operates on TCP port `80`, with a targetPort of `5000` for the pods.
- **Type**: Set as `ClusterIP`, indicating it's only accessible within the cluster.

#### Deployment Strategy

We use a Rolling Update strategy to ensure that there is minimal disruption to the service. This approach keeps at least one instance of the application running during updates.

#### Testing and Validation

After deployment, we validate the application through the following steps:

1. **Checking Pod and Service Status**: Utilising `kubectl get pods` and `kubectl get services`.
2. **Port Forwarding for Local Testing**: Using `kubectl port-forward <pod-name> 5000:5000`.
3. **Application Functionality Testing**: Accessing `http://127.0.0.1:5000` to ensure features like the orders table and Add Order function work as expected.

### CI/CD Pipeline with Azure DevOps

This section outlines the setup and configuration of our Continuous Integration and Continuous Deployment (CI/CD) pipeline. The pipeline automates the process of building, testing, and deploying our containerized application to Azure Kubernetes Service (AKS), integrating Azure DevOps with GitHub, Docker Hub, and AKS to streamline our deployment workflow.

#### Pipeline Overview

- **Source Control**: GitHub
- **CI/CD Tool**: Azure DevOps
- **Container Registry**: Docker Hub
- **Deployment Target**: Azure Kubernetes Service (AKS)

#### Azure DevOps Project Setup

1. Create a new Azure DevOps project named `<Project Name>` within your Azure DevOps account.
2. Configure GitHub as the source control system, selecting the `<GitHub Repository Name>` repository containing your application code.

#### Pipeline Configuration

##### Initial Setup

- Initialize the pipeline using the Starter Pipeline template in Azure DevOps, laying the groundwork for further customization.

##### Docker Hub Integration

1. Generate a personal access token on Docker Hub.
2. Configure an Azure DevOps service connection using this token to connect to Docker Hub.
3. Verify the successful establishment of the connection.

##### Building and Pushing Docker Images

- Modify the pipeline to include a Docker task with the `buildAndPush` command, specifying the `<username>/<Docker Image Name>` of your application.
- Set up the pipeline to trigger automatically upon any push to the main branch of your GitHub repository.

##### AKS Integration

1. Create and configure an AKS service connection in Azure DevOps, facilitating secure communication with your AKS cluster.
2. Modify the pipeline to incorporate the "Deploy to Kubernetes" task, using the `kubectl` command and leveraging our deployment manifest for automated application deployment to AKS.

#### Validation and Testing

- Monitor the status of pods within the AKS cluster to confirm correct creation.
- Initiate port forwarding using `kubectl` to access the application running on AKS locally using the comand below.
```bash
kubectl port-forward <podname> 5000:5000
```
Access the application at `http://127.0.0.1:5000` to ensure features all features are functioning properly.


### Secure Application Integration with Azure Key Vault and AKS

This section outlines the setup process, steps taken to secure application secrets with Azure Key Vault and Azure integration with AKS.

#### Azure Key Vault Setup

Azure Key Vault was created in Azure portal setting the region to "UK South" as our application and leaving all other settings unchanged.

##### Permissions

Assign the permission below to your Microsoft Entra user account:

- **Key Vault Administrator**: This role was assigned to enable full management capabilities over the Key Vault secrets.

##### Stored Secrets

The Key Vault holds four critical secrets for the application's backend database connection:

- **Server Name**: The hostname of the database server.
- **Server Username**: The login username for the database.
- **Server Password**: The login password for the database.
- **Database Name**: The specific database to connect to.

These secrets are utilized instead of hardcoded values in the application code to enhance security.

#### AKS Integration with Key Vault

##### Managed Identity for AKS

Enable managed identity for your AKS cluster, allowing secure, credential-less authentication to Azure Key Vault using code below:
```bash
az aks update --resource-group <resource-group> --name <aks-cluster-name> --enable-managed-identity
```
Extract client id for integration with Azure Key Vault from the AKS managed identity with code below:
```bash
az aks show --resource-group <resource-group> --name <aks-cluster-name> --query identityProfile
```

##### Permissions to Managed Identity

Grant **Key Vault Secrets Officer** role to the AKS managed identity empowering it to fetch and manage secrets as needed using code below:
```bash
az role assignment create --role "Key Vault Secrets Officer" \
  --assignee <managed-identity-client-id> \
  --scope /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.KeyVault/vaults/{key-vault-name}
```

#### Application Code Modifications

Integration of Azure Identity and Azure Key Vault libraries into the application code as below:
```python
from azure.identity import ManagedIdentityCredential
from azure.keyvault.secrets import SecretClient
```
And modify application code to securely retrieve secrets using code below. Ensure that string names correspond to those used in storing secrets in Azure Key Vaults:
```python
# Set keyvault url
key_vault_url = "https://<azure-key-vault-name>.vault.azure.net/"

# Set up Azure Key Vault client with Managed Identity
credential = ManagedIdentityCredential()
secret_client = SecretClient(vault_url=key_vault_url, credential=credential)

# Access the secret values from Key Vault
server_name = secret_client.get_secret("Server-Name").value
server_username = secret_client.get_secret("Server-Username").value
server_password = secret_client.get_secret("Server-Password").value
database_name = secret_client.get_secret("Database-Name").value

# database connection 
server = server_name
database = database_name
username = server_username
password = server_password
driver= '{ODBC Driver 18 for SQL Server}'
```

##### Docker Image Requirements Update

The `requirements.txt` file was updated to include the following libraries:

- azure-identity
- azure-keyvault-secrets

This ensures the Docker image is equipped with all dependencies required for the updated application code.

#### Testing and Deployment

##### Local Testing

Test the application locally using
```bash
docker run --name <container-name> -p 5000:5000 <docker username>/my-flask-img:latest
```
to confirm seamless integration with Azure Key Vault, ensuring secure retrieval of secrets.

##### Deployment to AKS

Following successful local tests, the application was deployed to the AKS cluster via the Azure DevOps CI/CD pipeline. 
The application was then tested again via port forwarding using code below to ensure that all features are working properly
```bash
kubectl port-forward <pod-name> 5000:5000
```






## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

- **Containerization:** Docker is employed to build and package all dependencies of the application into a docker image,and run the application in a container to make it consistency across different platforms.

- **Networking:** Terraform is employed to provision networking services for AKS. This involved creating a networking module and creating a resource gorup, virtual network, subnets for the control plane and worker nodes, network security group (NSG) and NSG rules to allow inbound traffic for kube-apiserver and ssh.

- **AKS Cluster:** Employs terraform to provision the aks cluster, node pool and service principal for the aks cluster module.

## Contributors 

- [Maya Iuga]([https://github.com/yourusername](https://github.com/maya-a-iuga))

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.
