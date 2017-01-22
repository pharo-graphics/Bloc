rectangle functions
merge: aRectangle 
	"Merge provided rectangle into me.
	aRectangle must not be nil"
	| useRcvr aLeft aTop aRight aBottom minX maxX minY maxY |

	useRcvr := true.

	aLeft := aRectangle left.
	aTop := aRectangle top.
	aRight := aRectangle right.
	aBottom := aRectangle bottom.

	minX := aLeft < left
		ifTrue: 
			[ useRcvr := false.
			aLeft ]
		ifFalse: [ left ].
	maxX := aRight > right
		ifTrue: 
			[ useRcvr := false.
			aRight ]
		ifFalse: [ right ].
	minY := aTop < top
		ifTrue: 
			[ useRcvr := false.
			aTop ]
		ifFalse: [ top ].
	maxY := aBottom > bottom
		ifTrue: 
			[ useRcvr := false.
			aBottom ]
		ifFalse: [ bottom ].
	
	"no need to merge do nothing"
	useRcvr 
		ifTrue: [ ^ self ].
	
	left := minX.
	top := minY.
	right := maxX.
	bottom := maxY