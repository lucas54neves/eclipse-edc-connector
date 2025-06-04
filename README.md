# Eclipse EDC - Connector

This repository contains helper resources to build the [Minimum Viable Dataspace](https://github.com/eclipse-edc/MinimumViableDataspace) (MVD) images and a Helm chart for deploying an EDC connector.

## Dockerfile

The provided `Dockerfile` clones the MVD repository and builds the runtime images using the Gradle tasks documented in the MVD project. A temporary Docker daemon is started inside the build container so the `dockerize` tasks can create the images `controlplane:latest`, `dataplane:latest`, `catalog-server:latest` and `identity-hub:latest`.

Build the images with:

```bash
docker build -t mvd-builder .
```

The resulting container image `mvd-builder` contains the MVD repository along with the Docker images produced by the build.

## Helm chart

Under `charts/connector` a basic Helm chart is provided. It deploys a control plane and a data plane using the images built from the Dockerfile. Default values can be adjusted in `values.yaml`.

Install the chart into a Kubernetes cluster with:

```bash
helm install my-connector charts/connector
```

The chart exposes services and an ingress similar to the Terraform deployment supplied by the MVD project.
