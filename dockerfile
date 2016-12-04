# Build from kaggle python image
FROM kaggle/python

# Make kaggler user
RUN useradd -m -s /bin/bash -N -u 1000 kaggler && \
  mkdir -p /wd && \
  chown kaggler /wd

USER kaggler

# Include the gym code in gym
ADD ./gym/kagglegym.py /wd/gym/kagglegym.py
ADD ./gym/__init__.py /wd/gym/__init__.py

# Include the training data in input
ADD  ./gym/input/train.h5 /wd/gym/input/train.h5


WORKDIR /wd

# Port for jupyter notebook
EXPOSE 8888
