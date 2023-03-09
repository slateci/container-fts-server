# Cern FTS Image (Modified)

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Slightly modified container image for Cern's FTS project.

## Image Tags

* `X.Y.Z`: A specific version of FTS.

See [OSG Harbor](https://hub.opensciencegrid.org/harbor/projects/50/repositories/fts-server) for a complete listing.

## How to Build

This image is built by GitHub any time a commit is made and tagged. But if you need to build the image on your own locally, do the following:

1. Install [Podman](https://podman.io/getting-started/installation) or [Docker](https://docs.docker.com/get-docker/).
    * In the commands below, `podman` may be interchanged with `docker` depending on your choice.
2. `cd` into the directory containing this repository.
3. Build the image:

   ```shell
   podman build --file Containerfile --tag fts-server:local .   
   ```

## How to Use

1. Install [Podman](https://podman.io/getting-started/installation) or [Docker](https://docs.docker.com/get-docker/).
    * In the commands below, `podman` may be interchanged with `docker` depending on your choice.
2. Pull this image from [OSG Harbor](https://hub.opensciencegrid.org/harbor/projects/50/repositories/fts-server) (or use the image you built above `fts-server:local`):

   ```shell
   podman pull hub.opensciencegrid.org/slate/fts-server:X.Y.Z
   ```
3. Perform an action in the container.

## How to Contribute

> **_NOTE:_** Several versions of FTS are concurrently supported.

1. To contribute to `vX.Y**`, check out the matching `releases/X.Y` branch.
   * If `releases/X.Y` does not yet exist, create it by branching off `master`.
2. Complete the desired edits, commit, and push to GitHub's upstream `releases/X.Y` branch.
3. Verify the resulting [Checks (Image) GitHub Action](https://github.com/slateci/container-fts-server/actions/workflows/checks-image.yml) completes successfully (Dockle & Trivy).
4. If the checks pass, apply a Git tag with a `v` prefix and push to GitHub. For example:
   * `v1.0.1` -- resulting image will be tagged with `latest`, `1.0`, and `1.0.1`
   * `v3.12.5-pre.20230308-1948` -- resulting image will be tagged with `3.12.5-pre.20230308-1948`
   * `v3.12.5-test-20230308-1930` -- resulting image will be tagged with `3.12.5-test-20230308-1930`
   * `vMyTestTag` -- resulting image will be tagged with `MyTestTag`
5. At this point the [Release GitHub Action](https://github.com/slateci/container-fts-server/actions/workflows/release.yml) will trigger to build, check, and deploy the resulting image to [OSG Harbor](https://hub.opensciencegrid.org/harbor/projects/50/repositories/fts-server).

## Resources

* [Cern: fts3](https://gitlab.cern.ch/fts/fts3).
