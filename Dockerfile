FROM ubuntu:16.04

LABEL maintainer = "https://github.com/eae3532/practicalsproject"
 
RUN apt-get update \
    && apt-get install -y python-pip build-essential \
	&& apt-get install python-matplotlib \
	&& apt-get install python-mpltoolkits.basemap \
#	&& apt-get install libgeos-3.X.X \
#	&& apt-get install libgeos-dev \  
    && apt-get -y autoremove \
    && apt-get -y clean  \
    && rm -rf /var/lib/apt/lists/*

# pip upgrade removed see ISSUES


RUN pip install jupyter numpy scipy pandas ipywidgets \
	&& pip install jupyter_contrib_nbextensions netCDF4 \
#	&& pip install --user https://github.com/matplotlib/basemap/archive/master.zip \
    && rm -r /root/.cache/pip 

# set up the workspace folder
RUN mkdir /workspace 

# copy in local files
COPY docs /workspace

# copies nbextensions JS and CSS files to local jupyter directories
RUN jupyter contrib nbextension install --user

# enable widgets
RUN jupyter nbextension enable --py widgetsnbextension 
	

# Add a notebook config settings
RUN mkdir -p -m 700 /root/.jupyter/ && \
echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py && \
echo "c.NotebookApp.password = ''" >> /root/.jupyter/jupyter_notebook_config.py && \
echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py 

WORKDIR /workspace

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents
# kernel crashes and is recommended
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8888
CMD ["jupyter", "notebook", "--no-browser", "--allow-root"]




