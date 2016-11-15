manager -> element
onDispatchFirstPass: aCommand
	"Notify an infinite element that aCommand was dispatched
	during first pass, allowing element to perform further
	dispatches, for example to layout in order to synchronise updates.
	aCommand must not be nil"
	
	^ self subclassResponsibility