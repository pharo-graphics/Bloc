rope - accessing
clearAttributes: aStart to: anEnd
	"Clear all attributes"

	^ self clearAttributes: aStart to: anEnd if: [ :each | true ]