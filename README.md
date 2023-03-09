# Cern FTS Image (Modified)

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Release](https://github.com/slateci/container-fts-server/actions/workflows/release.yml/badge.svg)](https://github.com/slateci/container-fts-server/actions/workflows/release.yml)

Slightly modified container image for Cern's FTS project.

## Image Tags

* `latest`: Latest stable version of FTS.
* `X.Y.Z`: Specific version of FTS. 

## How to Build

This image is built on GitHub automatically any time a commit is made or merged to the `master` branch and tagged. But if you need to build the image on your own locally, do the following:

1. Install [Podman](https://podman.io/getting-started/installation) or [Docker](https://docs.docker.com/get-docker/).
    * In the commands below, `podman` may be interchanged with `docker` depending on your choice.
2. `cd` into the directory containing this repository.
3. Build the image:

   ```shell
   podman build --file Containerfile --tag fts-server:latest .   
   ```

## How to Use

1. Install [Podman](https://podman.io/getting-started/installation) or [Docker](https://docs.docker.com/get-docker/).
    * In the commands below, `podman` may be interchanged with `docker` depending on your choice.
2. Pull this image from [OSG Harbor](https://hub.opensciencegrid.org/harbor/projects/50/repositories/fts-server) (or use the image you built above `fts-server:latest`):

   ```shell
   podman pull hub.opensciencegrid.org/slate/fts-server:latest
   ```

## How to Contribute

1. Submit a pull request against `master`.
2. Once the automated status checks pass, complete the pull request by squash-merging with `master`, and delete the associated branch.
3. Apply a [semantic version](https://semver.org/) tag to the resulting commit (e.g. `v1.0.1`).
4. At this point the automatic image build on GitHub will trigger, tagging the new image with the semantic version and `latest`.

## Resources

* [Cern: fts3](https://gitlab.cern.ch/fts/fts3).
