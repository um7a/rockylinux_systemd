# rockylinux_systemd

systemd enabled Rocky Linux Docker image.

## Usage

```bash
$ make

  TARGETS
    build ... Build docker image local/rockylinux_systemd
    clean ... Clean docker image local/rockylinux_systemd
    run   ... Run docker container using image local/rockylinux_systemd
    stop  ... Stop docker container which was created by run target

```

### Build docker image

```bash
$ make build
```

### Run container

```bash
$ make run
```

### Stop container

```bash
$ make stop
```

### Delete docker image

```bash
$ make clean
```
