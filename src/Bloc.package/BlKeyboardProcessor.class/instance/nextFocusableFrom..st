focus navigation
nextFocusableFrom: anElement
	|p  nextIndex|
	anElement ifNil:[^ nil].
	"return the first focusable child if any"
	anElement children do: [ :each| each isFocusable ifTrue:[^ each] ].
	"no parent, return nil"
	p := anElement parent ifNil:[ ^ nil].
	nextIndex := (p childIndexOf: anElement) + 1.
	"last child, back to parent"
	p childrenCount < nextIndex ifTrue:[^ self nextFocusableFrom: p parent ].
	"pick the next focusable sibling"
	nextIndex to: p childrenCount do:[:i| 
		(p children at:i) isFocusable ifTrue:[^ (p children at:i)] ].
	"else, back to parent"
	^ self nextFocusableFrom: p parent
	
