# Flask Web Application with Modern CSS

A simple web application built with Flask and modern CSS that demonstrates a clean, responsive design.

## Project Structure
```
flask-app/
├── src/
│   ├── backend/
│   │   ├── __init__.py
│   │   ├── app.py
│   │   └── requirements.txt
│   └── frontend/
│       ├── static/
│       │   ├── css/
│       │   │   └── style.css
│       │   └── js/
│       │       └── main.js
│       └── templates/
│           ├── base.html
│           └── index.html
├── Dockerfile
├── docker-compose.yml
├── kubernetes/
│   ├── deployment.yaml
│   └── service.yaml
└── README.md
```

## Features
- Modern, responsive design using CSS
- Flask backend with RESTful endpoints
- Docker containerization
- Kubernetes deployment configuration
- Health check endpoints
- Container hostname display

## Prerequisites
- Python 3.8+
- Docker
- Kubernetes cluster (for deployment)
- kubectl configured

## Local Development

1. Create Python virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
cd src/backend
pip install -r requirements.txt
```

3. Run the application:
```bash
python app.py
```

4. Access the application at http://localhost:5000

## Docker Build and Run

1. Build the Docker image:
```bash
docker build -t flask-app:latest .
```

2. Run the container:
```bash
docker run -d -p 5000:5000 flask-app:latest
```

3. Access the application at http://localhost:5000

## Kubernetes Deployment

1. Push the image to a container registry:
```bash
docker tag flask-app:latest <your-registry>/flask-app:latest
docker push <your-registry>/flask-app:latest
```

2. Update the image in kubernetes/deployment.yaml with your registry path

3. Deploy to Kubernetes:
```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

4. Get the service IP/URL:
```bash
kubectl get svc flask-app-service
```

## Application Features
- Modern, responsive UI
- Container hostname display
- Health check endpoint (/health)
- API endpoints:
  - GET /: Main page
  - GET /health: Health check
  - GET /api/info: System information

## Development Notes
- The application uses Flask for the backend
- Frontend is built with modern CSS (no framework)
- Docker image is based on Python alpine for minimal size
- Kubernetes configuration includes:
  - Deployment with 3 replicas
  - LoadBalancer service
  - Health checks
  - Resource limits

## Troubleshooting
- Check container logs: `docker logs <container-id>`
- Check pod logs: `kubectl logs <pod-name>`
- Check pod status: `kubectl describe pod <pod-name>` 