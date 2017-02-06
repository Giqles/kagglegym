## kagglegym

This dockerfile builds from the `kaggle/python` image, and adds the training data
and kagglegym emulation code written by
[Frans Slothouber](https://www.kaggle.com/slothouber/two-sigma-financial-modeling/kagglegym-emulation).

This allows offline working on the two-sigma-financial-modeling challenge.

### Installation

After you've cloned this repo, you'll need docker. These [installation instructions](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04#step-6-—-committing-changes-in-a-container-to-a-docker-image) seem pretty sensible.

When that's set up, you're almost ready to build the image. Before you do that you'll need to agree
to the rules of the competition and download the training data from [here](https://www.kaggle.com/c/two-sigma-financial-modeling/data).

When that's downloaded, extract the `train.h5` file to the `../gym/input/` directory
of this repo. Then, from the top level of this repo, you should just need to call:
```
docker build -t kagglegym .
```
From the top level of the repository. Include the `.`! If you're concerned about storage you can include `--rm=true`, to remove intermediate containers after a successful build.

Health warning; the `kaggle/python` image is pretty large at c. 7Gb, so it might
take a while to download.

### Container usage

To launch the image and play around:

```
docker run -it kagglegym
python
>>> import kagglegym
>>> kagglegym.test()
```

Assuming you want to save results for local viewing, or run local code inside
the image, it's usually easiest to link a directory between the local machine
and the container. This command will launch the container with the current
working directory linked to the container working directory:

```
docker run -it -v $(pwd):/wd kagglegym
```

And finally if you want to use this with Jupyter notebook, you'll want to link a port
and pass the command to start the notebook on launching the container.
```
docker run -it -v $(pwd):/wd -p 8888:8888 kagglegym jupyter notebook --port=8888 --ip=0.0.0.0
```
If you then head to `localhost:8888`, in your web browser you should be able to
use notebooks as normal. Again, the working directory you launched the container
from will be linked to the container itself.

### kagglegym usage

`kagglegym` should function in the same way as described in the api-overview [here](https://www.kaggle.com/jeffmoser/two-sigma-financial-modeling/kagglegym-api-overview).

You *should* be able copy and paste your local code to kaggle scripts/notebooks
and have it function the same way.
