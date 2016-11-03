enumerating
with: aCollection inject: thisValue into: binaryBlock
	"Reversed implementation of Collection>>#inject:into:"
	| nextValue |
	nextValue := thisValue.
	aCollection reverseDo: [ :each | nextValue := binaryBlock value: nextValue value: each ].
	^ nextValue