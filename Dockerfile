FROM ubuntu:16.04

LABEL maintainer = "https://github.com/eae3532/practicalsproject"

# python set up , check py 2 
RUN apt-get update \
    && apt-get install -y python-pip build-essential \
    && apt-get -y autoremove \
    && apt-get -y clean  \
    && rm -rf /var/lib/apt/lists/*

# install libraries, cartopy removed see Backlog issues
RUN pip install pip -U \
    && pip install jupyter numpy scipy pandas matplotlib ipywidgets\
	&& pip install bqplot vega jupyter_contrib_nbextensions\
    && rm -r /root/.cache/pip 

# set up the folders, script this out
RUN mkdir /EAE3532 && mkdir /EAE3532/Examples && mkdir /EAE3532/Practicals
RUN mkdir /EAE3532/Tutorials && mkdir /EAE3532/Help

# copy in local notebooks, script as well
COPY docs/examples /EAE3532/Examples
COPY docs/practicals /EAE3532/Practicals
COPY docs/tutorials /EAE3532/Tutorials
COPY docs/help /EAE3532/Help

# copies nbextensions JS and CSS files to local jupyter directories
RUN jupyter contrib nbextension install --user

# enable widgets
RUN jupyter nbextension enable --py widgetsnbextension

# Add a notebook profile
# DEV changes CMD ?
RUN mkdir -p -m 700 /root/.jupyter/ && \
echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py && \
echo "c.NotebookApp.password = ''" >> /root/.jupyter/jupyter_notebook_config.py && \
echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py 

# expose notebook port 
EXPOSE 8888 

WORKDIR /EAE3532

CMD jupyter notebook --ip="*" --no-browser --allow-root
