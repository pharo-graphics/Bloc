manager -> element
onDispatchSecondPass: aCommand
	"Notify an infinite element that aCommand was dispatched
	during second pass, allowing element to perform further
	dispatches, for example to layout in order to synchronise updates.
	aCommand must not be nil"
	
	^ self subclassResponsibility