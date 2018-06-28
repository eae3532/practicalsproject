
// run all cells on launch
function launch_notebook (evt) {
  if (Jupyter.notebook.kernel 
      && Jupyter.notebook.kernel.is_connected()){
	var cells = Jupyter.notebook.get_cells();
	//Jupyter.notebook.execute_all_cells(); 
	console.log("Cells executed from custom.js");
	}
}

// need these 3 events before cell execution
$([Jupyter.events]).on('kernel_ready.Kernel kernel_created.Session notebook_loaded.Notebook', launch_notebook);
