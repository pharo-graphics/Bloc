private
askFileName
	^ UIManager default 
		fileSave: 'Save Element as ', self extension asUppercase 
		initialAnswer: (self element class name, '-', self element hash asString,'.' , self extension)
		extensions: { self extension } 
		path: Smalltalk imageDirectory