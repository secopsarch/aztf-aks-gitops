# Contributing to Azure Terraform AKS GitOps Framework

👋 First off, thank you for considering contributing to our project! It's people like you that make this framework a great tool for the community.

## 📝 Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

## 🚀 How Can I Contribute?

### 1. 🐛 Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- 📋 Use a clear and descriptive title
- 🔍 Describe the exact steps to reproduce the problem
- 📝 Provide specific examples to demonstrate the steps
- 🖼️ Include screenshots if applicable
- 📊 Share relevant configuration details

### 2. 💡 Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- 🎯 Use a clear and descriptive title
- 📝 Provide a step-by-step description of the suggested enhancement
- 🔍 Provide specific examples to demonstrate the steps
- 📊 Describe the current behavior and explain the behavior you expected to see
- 💭 Explain why this enhancement would be useful

### 3. 🔧 Pull Requests

Here's a quick guide to submitting PRs:

1. Fork the repo and create your branch from `main`
2. If you've added code that should be tested, add tests
3. If you've changed APIs, update the documentation
4. Ensure the test suite passes
5. Make sure your code lints
6. Issue that pull request!

## 💻 Development Setup

1. **Prerequisites**
```bash
# Required tools and versions
az --version        # Azure CLI >= 2.40.0
terraform --version # Terraform >= 1.0.0
kubectl version     # kubectl >= 1.24
flux --version     # Flux >= 0.38.0
```

2. **Local Development**
```bash
# Clone your fork
git clone https://github.com/<your-username>/aztf-aks-gitops.git

# Add upstream remote
git remote add upstream https://github.com/original/aztf-aks-gitops.git
```

## 📝 Style Guidelines

### Terraform Style
- Use consistent naming conventions
- Follow HashiCorp's style conventions
- Document all variables and outputs
- Use workspaces for environment separation

```hcl
# Good
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Bad
variable "rg_name" {
  type = string
}
```

### Kubernetes Manifests
- Use consistent indentation
- Include resource limits
- Add appropriate labels and annotations
- Document configuration options

```yaml
# Good
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  labels:
    app: my-app
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: my-app
        resources:
          limits:
            cpu: "1"
            memory: "1Gi"
```

### Git Commit Messages
- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters
- Reference issues and pull requests liberally after the first line

## 📚 Documentation Guidelines

1. **README Updates**
   - Keep the main README.md up to date
   - Document new features and changes
   - Include examples and use cases

2. **Module Documentation**
   - Document all module inputs and outputs
   - Provide usage examples
   - Include architecture diagrams

3. **Code Comments**
   - Comment complex logic
   - Explain "why" not "what"
   - Keep comments up to date

## 🧪 Testing Guidelines

1. **Terraform Testing**
   - Write terratest cases
   - Include input validation tests
   - Test across different environments

2. **Kubernetes Testing**
   - Test deployments in isolation
   - Validate resource configurations
   - Check for security best practices

## 🏷️ Pull Request Process

1. Update the README.md with details of changes if applicable
2. Update the CHANGELOG.md following semantic versioning
3. The PR will be merged once you have the sign-off of two maintainers

## ⭐ Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Project documentation

## 📫 Getting Help

- 💬 Join our [Discord channel](https://discord.gg/your-channel)
- 📧 Email the maintainers
- 🎯 Check the [Wiki](https://github.com/yourusername/aztf-aks-gitops/wiki)

---

Thank you for contributing to Azure Terraform AKS GitOps Framework! 🚀 