# ci

- CI (IaC DevOps image)

## How to push new Docker tag

- update `Dockerfile`, commit and push changes
- Pipeline will be auto started
- Image is push to Github container registry

## How to update DevOps Tools

- update ARG for tools version
- run the pipeline manually to fetch latest versions

## Build/Use the container locally

```bash
# Build the docker container named rails-iac-image
docker build . -t rails-iac-image
```

If you need to change the version of any of the binaries, you can pass those variables in as --build-arg parameters:

```bash
# Build the docker container with specific tool versions
docker build . --build-arg TERRAFORM_VERSION=1.0.2 --build-arg TERRAGRUNT_VERSION=0.31.0 -t rails-iac-image
```

Once the container has been built, you can run the container, mounting the current directory to /work:

```bash
# Run the container, mounting the current directory at /work
docker run -it -v $(pwd):/work rails-iac-image /bin/bash
```