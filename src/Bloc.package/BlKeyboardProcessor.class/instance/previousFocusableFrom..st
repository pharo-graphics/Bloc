focus navigation
previousFocusableFrom: anElement
	|p  prevIndex |
	anElement ifNil:[^ nil].
	
	"no parent, return last focusable child or nil"
	p := anElement parent ifNil:[ "return the last focusable child if any"
		anElement children reverse do: [ :each| each isFocusable ifTrue:[^ self previousFocusableChildIn: each] ]. ^ nil].
	
	prevIndex := ((p childIndexOf: anElement) - 1) .
	"first child, return parent"
	(prevIndex < 1)ifTrue:[^ p].
	
	"pick the previous focusable sibling"
	^ self previousFocusableChildIn: p startAt: prevIndex. 
	
