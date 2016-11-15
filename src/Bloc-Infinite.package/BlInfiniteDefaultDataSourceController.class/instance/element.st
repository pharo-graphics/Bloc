accessing
element
	"Return infinite element used in communication with data source manager.
	element can not be nil"
	<return: #BlInfiniteElement>
	self assert: element isNotNil.
	
	^ element