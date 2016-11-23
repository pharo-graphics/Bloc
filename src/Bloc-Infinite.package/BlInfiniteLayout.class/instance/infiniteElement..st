initialization
infiniteElement: anInfiniteElement
	"Attach infinite layout to its element.
	It is only possible to attach infinite element once!
	anInfiniteElement must not be nil"
	self assert: [ infiniteElement isNil ] description: [ 'Infinite element is already attached' ].
	self assert: [ childManager isNil ] description: [ 'Child manager must not be set' ].
	self assert: [ anInfiniteElement isNotNil ] description: [ 'Can not attach nil infinite element' ].
	
	infiniteElement := anInfiniteElement.
	childManager := infiniteElement childManager.
	width := infiniteElement width.
	height := infiniteElement height.

	widthSpec := BlMeasurementSpec exact: width.
	heightSpec := BlMeasurementSpec exact: height