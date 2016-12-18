physics
calculateDeltaYToMakeVisible: anElement snap: aSnapPreference
	"Calculates the vertical scroll amount necessary to make the given element fully visible"
	<return: #Number>
	| aLayout aConstraints aTop aBottom aStart anEnd |

	aLayout := self layout.

	aLayout canScrollVertically
		ifFalse: [ ^ 0 ].
	
	aConstraints := anElement constraints.
	aTop := (aLayout decoratedTop: anElement) - aConstraints margin top.
	aBottom := (aLayout decoratedBottom: anElement) + aConstraints margin bottom.
	aStart := aLayout paddingTop.
	anEnd := aLayout height - aLayout paddingBottom.
	
	^ self calculateDelta: aTop @ aBottom toFit: aStart @ anEnd snap: aSnapPreference