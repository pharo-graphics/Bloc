text - attributes
unstyle: aFromIndex to: aToIndex
	<return: #BlText>
	| anUnstyledRope |

	"First refer original rope to support multithreading"
	anUnstyledRope := rope.
	anUnstyledRope := anUnstyledRope
		clearAttributes: aFromIndex
		to: aToIndex
		if: [ :anAttribute | anAttribute isOverwritableByStyler ].

	self rope: anUnstyledRope