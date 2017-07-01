focus
focusables: anOrderedCollection along: aBlFocusSearchDirection of: anElement
	"We always add visible children and skip anElement itself if there are focusable descendants"
	| focusablesCount |

	"store how many focusable element we have in collection before adding children
	in order to compare with later and check if we need to add anElement"
	focusablesCount := anOrderedCollection size.
	
	anElement children
		select: [ :aChild | aChild isVisible ]
		thenDo: [ :aChild | aChild focusables: anOrderedCollection along: aBlFocusSearchDirection ].
		
	(anElement isFocusable and: [ focusablesCount = anOrderedCollection size ])
		ifTrue: [ anOrderedCollection add: anElement ]