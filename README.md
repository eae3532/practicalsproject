# EAE3532 Physics of the Solid Earth - Practicals Project

This is the source repository for the EAE3532 practicals project.

### Current Development

Creating and testing Docker image based from the anaconda3 distribution.  
Creating and testing conda environment files.  
Creating and testing Notebook submit and save functionality.  
  
See DEV/Backlog2 on the project Drive for a list of development tasks.


### Running from Docker Terminal or Kitematic

__docker run -it -p 8888:8888 eae3532/practicals__  
  
This will pull the image from Docker Hub when run for the first time.  
You can then open a browser at  
  
__http://dockervirtualhostIP:8888__
  
where the docker virtualhostIP appears at the top of the docker terminal.  
  
eg. __http://192.168.99.100:8888__  

### Conda Environment  
  
To set-up the project environment locally from the _environment.yml_ file,  
  
__conda env create -n eae3532 -f environment.yml__  
__conda activate eae3532__  

Then install Jupyter and extensions into the activated environment with,  

__conda install jupyter__  
__conda install -c conda-forge jupyter_contrib_nbextensions__  


#### Enabling Extensions

The nbextensions below are used in the notebooks and can be enabled from the dashboard interface or at the command line,  
  
__jupyter nbextension enable snippets_menu/main__  
__jupyter nbextension enable hide_input/main__  
__jupyter nbextension enable equation-numbering/main__    
__jupyter nbextension enable --py --sys-prefix widgetsnbextension__  