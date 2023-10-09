<h2 align="center">
    <a href="https://nullplatform.com" target="blank_">
        <img height="100" alt="Nullplatform" src="https://nullplatform.com/favicon/android-chrome-192x192.png" />
    </a>
    <br>
    <br>
    Nullplatform Asset Push GitHub Action
    <br>
</h2>

## Overview

The "Nullplatform Asset Push" GitHub Action automates the process of pushing built assets required by nullplatform. It supports various asset types, including Docker images and Lambda functions, and allows for customization of working directories, output locations, and AWS credentials (for pushing assets to ECR or S3 Buckets).

## Table of Contents

- [Inputs](#inputs)
- [Outputs](#outputs)
- [Usage Examples](#usage-examples)
  - [Use Case 1: Push a Docker Image](#use-case-1-push-a-docker-image)
  - [Use Case 2: Push a Lambda Function](#use-case-2-push-a-lambda-function)
  - [Use Case 3: Custom Directory](#use-case-3-custom-directory)
- [Supported Repositories](#supported-repositories)
  - [Github Packages](#github-packages)
  - [AWS (ECR and S3)](#aws-ecr-and-s3)
- [No Dependencies or Commands](#no-dependencies-or-commands)
- [License](#license)

## Inputs

### `build-id`

- **Description**: The ID of the build where the asset to be pushed belongs.
- **Required**: Yes

### `type`

- **Description**: The type of asset to be pushed (e.g., `docker-image`, `lambda`, etc.).
- **Required**: Yes

### `build-working-directory`

- **Description**: The directory where the build process took place.
- **Required**: No
- **Default**: `.` (current directory)

### `asset-working-directory`

- **Description**: The directory containing source code and assets for the build process.
- **Required**: No
- **Default**: `.` (current directory)

### `asset-output-directory`

- **Description**: The directory where built assets are located.
- **Required**: No
- **Default**: `build`

### `name`

- **Description**: The name of the asset being pushed.
- **Required**: No
- **Default**: `main`

### `url`

- **Description**: Predefined asset URL. Advanced usage and not recommended.
- **Required**: No

### `api-key`

- **Description**: The API key required for authentication if not logged in.
- **Required**: No

## Outputs

### `asset-id`

- **Description**: The ID of the pushed asset.

### `asset-name`

- **Description**: The name of the pushed asset.

### `asset-path`

- **Description**: The path to the pushed asset.

## Usage Examples

### Use Case 1: Push a Docker Image

```yaml
name: Push Docker Image

on:
  push:
    branches:
      - main

jobs:
  push-assets:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Push Docker Image
        id: push-docker-image
        uses: nullplatform/github-action-asset-push@v1
        with:
          build-id: 12345  # Replace with your build ID
          type: docker-image
          name: my-docker-image

      ##
      ## Other steps
      ##
```

In this example, the action pushes a Docker image with the name `my-docker-image`.

### Use Case 2: Push a Lambda Function

```yaml
name: Push Lambda Function

on:
  push:
    branches:
      - main

jobs:
  push-assets:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Push Lambda Function
        id: push-lambda-function
        uses: nullplatform/github-action-asset-push@v1
        with:
          build-id: 12345  # Replace with your build ID
          type: lambda
          name: my-lambda-function

      ##
      ## Other steps
      ##

```

In this example, the action pushes a Lambda function with the name `my-lambda-function`.

### Use Case 3: Custom Directory

```yaml
name: Custom Directory

on:
  push:
    branches:
      - main

jobs:
  push-assets:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Push Assets with Custom Directory
        id: push-assets-custom
        uses: nullplatform/github-action-asset-push@v1
        with:
          build-id: 12345  # Replace with your build ID
          type: docker-image
          name: custom-docker-image
          build-working-directory: path/to/build

      ##
      ## Other steps
      ##

```

In this example, the action pushes a Docker image from custom directory `path/to/build`.

## Supported Repositories

This action supports the following repositories out of the box:

### GitHub Packages

To use this action with GitHub Packages, you must configure the following permissions in your workflow YAML:

```yaml
permissions:
  contents: read
  packages: write
```

### AWS (ECR and S3)

This action supports authentication for AWS repositories, including ECR (Elastic Container Registry) and S3 (Simple Storage Service). You can configure authentication using the following methods:

* **Access Key and Access Secret**: Provide your AWS access key and secret access key for authentication.
* **Role to Assume**: You can specify a role to assume with support for chaining.

The required parameters for authentication are automatically provided by our [secrets and variables action](https://github.com/nullplatform/github-action-secrets-and-variables).

## No Dependencies or Commands

Please note that this action does not install any dependencies or commands. It is the user's responsibility to ensure that the required build command and dependencies are available in the execution environment.

## License

This GitHub Action is licensed under the [MIT License](LICENSE).
