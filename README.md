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
