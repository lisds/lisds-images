# LIS Docker defines for JupyterHub

## Build the image locally

With a given (specified) tag of `v002`:

```
docker build -t lisds/lisds-images:v002 .
```

Or you can use the `make_image.sh` script to build with a tag from the current commit:

```
./make_image.sh lishub-base
```

## Dockerhub

The image can be pushed up to Dockerhub directly.  This is the manual incantation:

```
docker login --username=lisds
docker push lisds/lisds-images:v002
```

You will also see the relevant instructions at the end of output from
`./make_image.sh` above.

If you get a "User interaction is not allowed." error at the ``login``
stage, you may get further by running this command at the affected
terminal:

```
security unlock-keychain
```

See
<https://github.com/docker/docker-credential-helpers/issues/82#issuecomment-367258282>

## Testing locally

```bash
docker run -it --rm -p 8888:8888 lisds/lisds-images:002
```

then attach to <http://localhost:8888>.

This incantation allows `sudo` access and drops into a Bash shell.

```bash
docker run -it --rm -p 8888:8888 -e GRANT_SUDO=yes lisds/lisds-images:002 /bin/bash
```
