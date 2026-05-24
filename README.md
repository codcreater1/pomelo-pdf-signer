# 📂 Pomelo PDF Signer

An advanced, secure, and containerized web application designed for interactive, coordinate-based digital signature placement on PDF documents. Built with a modern Python backend architecture and a responsive React canvas overlay frontend.

---

## 🚀 Key Features

* **Interactive Canvas Overlay:** Smooth drag-and-drop web interface allowing users to visually place signatures precisely where they want them on the document.
* **Coordinate-Based Signature Placement:** Precision backend processing engine that calculates exact pixel offsets to burn signatures permanently into the PDF structure.
* **Robust Schema Validation:** Powered by **Pydantic v2** for secure type casting, bulletproof input sanitization, and structured API error handling.
* **Modern Python Backend:** Clean, modular, and fast API routing structure keeping frontend components and low-level PDF manipulation services separated.
* **Production-Ready Containerization:** Fully dockerized environment (`Docker-compose`) ensuring consistent developer and deployment setups across any OS.
* **Comprehensive Swagger UI Integration:** Built-in API documentation for seamless endpoint testing and route verification.

---

## 🛠️ Technical Tech Stack

| Layer | Technologies Used |
| :--- | :--- |
| **Backend Core** | Python, FastAPI / Framework Architecture |
| **Data Validation** | Pydantic v2 |
| **Frontend UI** | HTML5 Canvas, React, Modern CSS Frameworks |
| **DevOps & Infrastructure** | Docker, Docker-compose |
| **API Testing** | Swagger UI |

---

## 📦 Project Structure

```text
pomelo-pdf-signer/
├── app/                  # Python core backend logic & routes
├── frontend/             # Interactive Canvas overlay interface
├── tests/                # Quality Assurance simulation & endpoint tests
├── Dockerfile            # Container definition for the app service
├── docker-compose.yml    # Multi-container orchestration config
└── README.md             # Project documentation
⚙️ Quick Start Guide (Local Setup)
Follow these simple steps to spin up the entire application environment locally using Docker.

1. Prerequisites
Make sure you have Docker and Docker Compose installed on your system.

2. Clone the Repository
Bash
git clone [https://github.com/codcreater1/pomelo-pdf-signer.git](https://github.com/codcreater1/pomelo-pdf-signer.git)
cd pomelo-pdf-signer
3. Spin Up the Containers
Run the following command in the root directory to automatically fetch dependencies, configure networks, and launch both frontend and backend environments:

Bash
docker-compose up --build
4. Access the Application
Once the build is complete and the logs indicate running servers:

Frontend Web Interface: Open http://localhost:3000 (or your assigned frontend port)

Interactive API Docs (Swagger UI): Open http://localhost:8000/docs to test endpoints manually.

🤝 Team & Contributors
This system was collaboratively architected and maintained as a part of our modern software engineering internship/course cycle by the Pomelo Team:

Murat Can Nergiz (codcreater1) - Project Leader / Core Backend & Architecture

Arda (ardacodes1) - Core Infrastructure & Logic Development

Faik Arda (faikarda) - Quality Assurance, Testing & Deployment Verification

Eylül (Eylul35536) - Frontend UI Components & Canvas Overlay Design

📈 Quality Assurance & Code Standards
Our workflow implements a Mandatory Peer Approval Process. No feature branch is directly merged into main without thorough code reviews, Pydantic structure validations, and multi-user functional testing routines on separate simulation environments.
