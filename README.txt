# samtools-biobambam-docker
Docker image to run samtools and biobambam in Ubuntu 18.04

The image contains a full install of [samtools](https://github.com/samtools/samtools) and [biobambam](https://gitlab.com/german.tischler/biobambam2), including all necessary dependencies.

In detail, the image is set up with:
 - Ubuntu 18.04
 - samtools 1.10
 - biobambam2 2.0.146

To build the docker image you can do the following  in the folder with Dockerfile:
```bash
$ docker build --tag samtools-biobambam:1 .
```

To run the software you can do the following
```bash
$ docker run -it --rm -v $(pwd):/in -w /in samtools-biobambam:1
```