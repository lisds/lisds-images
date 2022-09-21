# Nipraxis Docker file for JupyterHub

## Build the image locally

```
docker build -t matthewbrett/nipraxis:v002 .
```

## Dockerhub

The image can be pushed up to Dockerhub directly::

```
docker login --username=matthewbrett
docker push matthewbrett/nipraxis:001
```

If you get a "User interaction is not allowed." error at the ``login`` stage,
you may get further by running this command at the affected terminal::

```
security unlock-keychain
```

See
<https://github.com/docker/docker-credential-helpers/issues/82#issuecomment-367258282>

## Testing locally

```bash
docker run -it --rm -p 8888:8888 matthewbrett/nipraxis:001
```

then attach to <http://localhost:8888>.

This incantation allows `sudo` access and drops into a Bash shell.

```bash
docker run -it --rm -p 8888:8888 -e GRANT_SUDO=yes matthewbrett/nipraxis:001 /bin/bash
```
