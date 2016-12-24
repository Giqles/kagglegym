# Build from kaggle python image
FROM kaggle/python

# Make kaggler user, wd, data for joblib
RUN useradd -m -s /bin/bash -N -u 1000 kaggler && \
  mkdir -p /wd && mkdir -p /data && \
  chown kaggler /wd && chown kaggler /data

USER kaggler

# Set up joblib temp
ENV JOBLIB_TEMP_FOLDER=/data/joblib

# Include the gym code in home/gym
ADD ./gym/kagglegym.py /home/kaggler/gym/kagglegym.py
ADD /gym/__init__.py /home/kaggler/gym/__init__.py

# Include the training data in input
ADD  ./gym/input/train.h5 /home/kaggler/gym/input/train.h5

# Add the location of kagglegym to the pythonpath
ENV PYTHONPATH="${PYTHONPATH}:/home/kaggler/gym"

WORKDIR /wd

# Port for jupyter notebook
EXPOSE 8888
