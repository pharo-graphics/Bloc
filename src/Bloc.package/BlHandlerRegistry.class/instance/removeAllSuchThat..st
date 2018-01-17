api - adding / removing
removeAllSuchThat: aBlock
	"Remove all event handlers for which aBlock returns true.
	Return a collection of removed handlers"
	<return: #SequenceableCollection of: #BlBasicEventHandler>
	
	^ self subclassResponsibility