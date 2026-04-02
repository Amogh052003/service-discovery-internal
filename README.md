# Service Discovery System with Consul (Microservices + AWS + Docker)

## Overview

This project implements a **dynamic service discovery system** using Consul, deployed on AWS using Terraform and Docker. It demonstrates how microservices can **register themselves automatically**, be discovered at runtime, and be accessed through a centralized API Gateway — without hardcoding service locations.

The system simulates **real-world microservice communication patterns**, focusing on scalability, flexibility, and decoupled architecture.

---

## Problem Statement

In traditional systems:

* Services depend on **hardcoded IPs/ports**
* Scaling services breaks communication
* No centralized visibility of services
* Failures are hard to detect

The system must:

* Allow services to **register dynamically**
* Enable runtime **service discovery**
* Route requests without static configuration
* Provide **health-aware service tracking**
* Work in a **containerized environment**

---

## Architecture

###  System Flow

```
Client
  ↓
API Gateway (Port 8000)
  ↓
Consul (Service Registry)
  ↓
Service A / Service B / Service C
```

---

## Tech Stack

| Layer             | Technology     |
| ----------------- | -------------- |
| Infrastructure    | AWS EC2        |
| IaC               | Terraform      |
| Containers        | Docker         |
| Orchestration     | Docker Compose |
| Service Discovery | Consul         |
| Backend Services  | Flask          |
| API Gateway       | Flask          |

---

## Workflow (End-to-End)

### 1. Infrastructure Provisioning

* Terraform provisions:

  * VPC
  * Subnet
  * Security Group
  * EC2 instance

---

### 2. Environment Setup

* EC2 instance installs Docker via startup script
* Application is deployed using Docker Compose

---

### 3. Service Deployment

Containers started:

* Consul (service registry)
* Service A
* Service B
* Service C
* API Gateway

---

### 4. Service Registration

Each service:

* Registers itself with Consul on startup
* Sends metadata including:

  * Service name
  * Address
  * Port
* Configures **health checks**

---

### 5. Consul (Service Registry)

* Maintains all active services
* Tracks health of each instance
* Provides API for service discovery

---

### 6. API Gateway Routing

* Receives client requests
* Queries Consul for service location
* Routes request dynamically

---

## Sample Outputs

### Gateway Request

```
GET /service-a/info
```

---

### Response

```json
{
  "service": "A",
  "time": "timestamp",
  "host": "container-id"
}
```

---

### Consul UI

```
http://<EC2_PUBLIC_IP>:8500
```

Shows:

* service-a
* service-b
* service-c
* consul

All with health status 

---

## Key Features

### 🔹 Dynamic Service Discovery

* No hardcoded IPs
* Services register themselves automatically

---

### 🔹 Health Checks

* Consul continuously monitors services
* Unhealthy services are excluded

---

### 🔹 API Gateway Routing

* Single entry point for all services
* Dynamic routing based on service registry

---

### 🔹 Containerized Architecture

* All services run in isolated containers
* Easy deployment and replication

---

### 🔹 Infrastructure as Code

* Entire infrastructure managed using Terraform

---

## Project Structure

```
.
├── service-a/
├── service-b/
├── service-c/
├── gateway/
├── consul/
├── docker-compose.yaml
└── terraform/
```

---

## Deployment

### 1. Provision Infrastructure

```bash
cd terraform
terraform init
terraform apply
```

---

### 2. Connect to EC2

```bash
ssh -i my-key.pem ubuntu@<PUBLIC_IP>
```

---

### 3. Deploy Application

```bash
git clone https://github.com/<your-username>/service-discovery-internal.git
cd service-discovery-internal
docker compose up --build -d
```

---

## Testing

### Access Gateway

```
http://<PUBLIC_IP>:8000/service-a/info
http://<PUBLIC_IP>:8000/service-b/info
http://<PUBLIC_IP>:8000/service-c/info
```

---

### Verify Consul

```
http://<PUBLIC_IP>:8500
```

---

## Design Decisions

### Why Consul?

* Lightweight service discovery
* Built-in health checks
* Easy API integration

---

### Why Docker Compose?

* Simple orchestration for single-node setup
* Fast local and cloud deployment

---

### Why API Gateway?

* Central entry point
* Decouples client from services

---

## Limitations

* Single-node deployment
* No load balancing
* No auto-scaling
* No CI/CD pipeline
* Limited observability

---

## Future Enhancements

* Multi-instance scaling of services
* Load balancing via Consul or Nginx
* Prometheus + Grafana monitoring
* CI/CD using GitHub Actions
* Kubernetes deployment
* Consul Connect (service mesh)

---

## Conclusion

This project demonstrates a **practical implementation of service discovery in a microservices architecture**. It showcases:

* Infrastructure automation using Terraform
* Containerized deployments
* Dynamic service registration and discovery
* Gateway-based routing

It serves as a strong foundation for building **scalable, production-grade distributed systems**.

---

## Author

**Amogh Lokhande**
🔗 https://www.linkedin.com/in/amogh-lokhande-49b631332/

---

⭐ If you found this useful, consider giving it a star!
