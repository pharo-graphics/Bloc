testing
containsRect: aRectangle
	"Answer whether aRectangle is within the receiver"
	<return: #Boolean>
	| aLeft aTop aRight aBottom |
	
	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.
	
	^ aLeft >= left and: [
		aTop >= top and: [
			aRight <= right and: [
				aBottom <= bottom ] ] ]