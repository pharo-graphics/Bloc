private
createWindowSpaceFor: aSpace
	"Note, that I use given space only to find out what window properties to use for created window.
	I do not create any strong or weak references to provided space"
	
	^ BlOSWindowSpace new