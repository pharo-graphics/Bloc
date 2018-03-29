configuration
packageNames
	"((#gtExample senders select: [ :each | each package name beginsWith: 'Bloc' ]) groupedBy: [ :each | each package name ]) keys"
	
	^  #(#'Bloc-Tests' #'Bloc-Extensions' #'Bloc-Examples' #'Bloc-SVG' #'Bloc-Layout-Tests')