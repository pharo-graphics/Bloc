private
dispatchCommand: aCommand
	"Dispatche data source update command to all interested objects,
	in this case to infinite element's layout.
	aCommand must not be nil"
	
	aCommand dispatchToLayout: self element layout