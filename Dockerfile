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

# set up the workspace folder
RUN mkdir /workspace 

# copy in local files
COPY docs /workspace

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

WORKDIR /workspace

CMD jupyter notebook --no-browser --allow-root
