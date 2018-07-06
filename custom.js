
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


// set - up the Snippets menu and any custom menu items
require(["nbextensions/snippets_menu/main"], function (snippets_menu) {
    console.log('Loading `snippets_menu` customizations from `custom.js`');
    var horizontal_line = '---';
    var custom_items = {
        'name' : 'Custom Menu',
        'sub-menu' : [
            {
                'name' : 'Menu item 1',
                'snippet' : ['Add snippet code here',],
            },
            {
                'name' : 'Menu Item 2',
                'snippet' : ['Add snippet code here',],
            },
        ],
    };
	// add default snippets menu and remove unwanted items
    snippets_menu.options['menus'] = snippets_menu.default_menus;
	snippets_menu.default_menus[0]['sub-menu'].splice(3, 1);
	snippets_menu.default_menus[0]['sub-menu'].splice(4, 3);
	snippets_menu.default_menus[0]['sub-menu'].splice(-1, 1);
	
	// push on custom snippets 
    //snippets_menu.options['menus'][0]['sub-menu'].push(horizontal_line);
    //snippets_menu.options['menus'][0]['sub-menu'].push(custom_items);
    console.log('Loaded `snippets_menu` customizations from `custom.js`');
});
