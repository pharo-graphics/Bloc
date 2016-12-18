physics
calculateDeltaXToMakeVisible: anElement snap: aSnapPreference
	"Calculates the horizontal scroll amount necessary to make the given element fully visible"
	<return: #Number>
	| aLayout aConstraints aLeft aRight aStart anEnd |

	aLayout := self layout.

	aLayout canScrollHorizontally
		ifFalse: [ ^ 0 ].
	
	aConstraints := anElement constraints.
	aLeft := (aLayout decoratedLeft: anElement) - aConstraints margin left.
	aRight := (aLayout decoratedRight: anElement) + aConstraints margin right.
	aStart := aLayout paddingLeft.
	anEnd := aLayout width - aLayout paddingRight.
	
	^ self calculateDelta: aLeft @ aRight toFit: aStart @ anEnd snap: aSnapPreference