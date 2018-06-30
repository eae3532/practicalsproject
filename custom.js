
// check current Jupyter docs to access actions
function launch_notebook (evt) {
  if (Jupyter.notebook.kernel 
      && Jupyter.notebook.kernel.is_connected()){
	var cells = Jupyter.notebook.get_cells();
	console.log('Custom.js loaded');
		
	}
}

// need these 3 events 
$([Jupyter.events]).on('kernel_ready.Kernel kernel_created.Session notebook_loaded.Notebook', launch_notebook);
