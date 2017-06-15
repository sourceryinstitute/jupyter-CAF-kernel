<div align="center">

# Fortran kernel for Jupyter with Coarray support

[![Binder](http://mybinder.org/badge.svg)](https://beta.mybinder.org/v2/gh/sourceryinstitute/jupyter-CAF-kernel/master)
[![](https://images.microbadger.com/badges/image/sourceryinstitute/jupyter-caf-kernel.svg)](https://microbadger.com/images/sourceryinstitute/jupyter-caf-kernel)
[![](https://images.microbadger.com/badges/version/sourceryinstitute/jupyter-caf-kernel.svg)](https://hub.docker.com/r/sourceryinstitute/jupyter-caf-kernel/)
[![](https://images.microbadger.com/badges/commit/sourceryinstitute/jupyter-caf-kernel.svg)](https://github.com/sourceryinstitute/jupyter-CAF-kernel#readme)
[![](https://images.microbadger.com/badges/license/sourceryinstitute/jupyter-caf-kernel.svg)][license]

</div>

----

## Quick start

 * [Try][try CAF] Coarray Fortran in the cloud with [GFortran] and [OpenCoarrays]
   using [Binder]: __http://bit.ly/TryCoarrays__  
   This will open the [`index.ipynb`] file in an interactive
   environment using [Binder].
 * Launch a full JupyterHub [Binder] environment in the cloud with access
   to
   [other science kernels][jupyter-stacks] in
   addition to Fortran with [OpenCoarrays]: __http://bit.ly/CAF-Binder__

## Run locally

```bash
docker pull sourceryinstitute/jupyter-caf-kernel:latest
docker run -i -t -p 8888:8888 sourceryinstitute/jupyter-caf-kernel:latest
```

You should see output similar to the following which will instruct you
to point your web browser to `http://localhost:8888/?token=...`

```
[I 19:29:08.089 NotebookApp] Writing notebook server cookie secret to /home/jovyan/.local/share/jupyter/runtime/notebook_cookie_secret
[W 19:29:08.188 NotebookApp] WARNING: The notebook server is listening on all IP addresses and not using encryption. This is not recommended.
[I 19:29:08.221 NotebookApp] JupyterLab alpha preview extension loaded from /opt/conda/lib/python3.5/site-packages/jupyterlab
[I 19:29:08.233 NotebookApp] Serving notebooks from local directory: /home/jovyan
[I 19:29:08.233 NotebookApp] 0 active kernels
[I 19:29:08.233 NotebookApp] The Jupyter Notebook is running at: http://[all ip addresses on your system]:8888/?token=67e0bf26a40f863c8af93c030de57b4802cd7b3d9f10ae17
[I 19:29:08.233 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 19:29:08.234 NotebookApp]

    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=67e0bf26a40f863c8af93c030de57b4802cd7b3d9f10ae17
```

When running locally (this way) you won't have access to the examples
folder or [`index.ipynb`].

## About

This Coarray Fortran kernel is still a bit rough around the edges. It
is a shameless fork of the [jupyter-c-kernel], quickly thrown
together. This is [licensed under the MIT license][license], as is
[jupyter-c-kernel]. I also drew inspiration from the
[jupyter-fortran-kernel].

### Whats up with the `prebuild` directory?

The `prebuild` directory is there so that the docker image used to
launch the Coarray Fortran kernel on [Binder] can be built
automatically on Docker Hub. The `Dockerfile` at the project root then
wraps the one located in `prebuild`. This is because we must compile
GCC from source to get a new enough version and this takes a very long
time. We don't want users to have to wait forever to spawn a new
notebook on [Binder], so we ensure that the base image is built ahead
of time, locally, or through the Docker Hub automated build process.

## Manual local installation

The recommended usage of this kernel is through [Binder] in the cloud,
or [via Docker, as described above](#Run-locally). If you decide to
install this kernel locally on your system you will need the following
software packages installed:

 * GCC and [GFortran] >= 7.1
 * [MPICH] >= 3.2
 * [OpenCoarrays]
 * [Jupyter]
 * Python 3
 * pip

### Step-by-step

 1. `git clone https://github.com/sourceryinstitute/jupyter-CAF-kernel`
 1. `cd jupyter-CAF-kernel`
 1. `pip install -e prebuild/jupyter-caf-kernel`
 1. `jupyter-kernelspec install prebuild/jupyter-caf-kernel/Coarray-Fortran/`
 1. `jupyter-notebook .`

## Contributing

Contributions are most welcome!

### ToDo

 * [ ] Use proper Python OOP class extension & better understand base class
 * [ ] Improve I/O
 * [ ] Improve exception handling and error reporting
 * [ ] Improve magics
 * [ ] Use [MetaKernel] to build the kernel and magics
 * [ ] Allow use of all aplicable [MetaKernel magics]
 * [ ] Don't attempt to compile code when only magics are present
 * [ ] Different flavors of Docker images (so that less space is
      used). See [jupyter/docker-stacks][jupyter-stacks]

### Version control

 1. [Fork]
 1. Create branches named `issue-X` where `X` is the number of the
    issue.
 1. Commit changes
 1. [Pull Request]

## License

[MIT][license]

[Binder]: https://beta.mybinder.org
[try CAF]: http://bit.ly/TryCoarrays
[GFortran]: https://gcc.gnu.org/wiki/GFortran
[OpenCoarrays]: https://github.com/sourceryinstitute/OpenCoarrays#readme
[`index.ipynb`]: https://nbviewer.jupyter.org/github/sourceryinstitute/jupyter-CAF-kernel/blob/master/index.ipynb
[jupyter-c-kernel]: https://github.com/brendan-rius/jupyter-c-kernel#readme
[jupyter-fortran-kernel]: https://github.com/ZedThree/jupyter-fortran-kernel
[MPICH]: https://www.mpich.org
[license]: https://github.com/sourceryinstitute/jupyter-CAF-kernel/blob/master/LICENSE
[Fork]: https://github.com/sourceryinstitute/jupyter-CAF-kernel/fork
[Pull Request]: https://github.com/sourceryinstitute/jupyter-CAF-kernel/compare?expand=1
[MetaKernel]: https://github.com/Calysto/metakernel#readme
[MetaKernel magics]: https://github.com/Calysto/metakernel/blob/master/metakernel/magics/README.md
[jupyter-stacks]: https://github.com/jupyter/docker-stacks#readme
[Jupyter]: https://jupyter.org
