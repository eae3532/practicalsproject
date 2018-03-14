FROM ubuntu:16.04

LABEL maintainer = "https://github.com/eae3532/practicalsproject"

# python set up , check py 2 
RUN apt-get update \
    && apt-get install -y python-pip build-essential \
    && apt-get -y autoremove \
    && apt-get -y clean  \
    && rm -rf /var/lib/apt/lists/*

# install libraries, remove unused demo libs
RUN pip install pip -U \
    && pip install jupyter numpy scipy pandas matplotlib \
	&& pip install cartopy bqplot vega jupyter_contrib_nbextensions\
    && rm -r /root/.cache/pip 

# set up the folders, script this out
RUN mkdir /EAE3532 && mkdir /EAE3532/Examples && mkdir /EAE3532/Practicals
RUN mkdir /EAE3532/Tutorials && mkdir /EAE3532/Help

# copy in local notebooks, script as well
COPY docs/examples /EAE3532/Examples
COPY docs/practicals /EAE3532/Practicals
COPY docs/tutorials /EAE3532/Tutorials
COPY docs/help /EAE3532/Help

# enable snippets
WORKDIR /root/.jupyter 
RUN snippets nbextension enable

WORKDIR /EAE3532

CMD jupyter notebook --ip="*" --no-browser --allow-root
