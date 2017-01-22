testing
containedInRect: aRectangle
	"Answer whether a receiver is within a aRectangle"
	<return: #Boolean>
	| aLeft aTop aRight aBottom |
	
	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.

	^ aLeft <= left and: [
		aTop <= top and: [
			aRight >= right and: [
				aBottom >= bottom ] ] ]