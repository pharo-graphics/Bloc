geometry bounds convertion
globalBoundsToMine: aBlBounds fromParent: aParentElement
	"In-place transform provided bounds from coordinate system of a given parent
	to my local coordinates and return a result"
	<return: #BlBounds>
	| theParents |

	aParentElement == self
		ifTrue: [ ^ aBlBounds ].

	self
		assert: [ self hasParent: aParentElement ]
		description: [ 'A given element must be my parent (be in my children composition tree)' ].

	theParents := Array streamContents: [ :aStream |
		| eachParent |
		
		aStream nextPut: self.
		eachParent := self parent.
		[ eachParent == aParentElement ] whileFalse: [
			aStream nextPut: eachParent.
			eachParent := eachParent parent ] ].

	theParents reverseDo: [ :eachParent | eachParent parentBoundsToLocal: aBlBounds ].

	^ aBlBounds