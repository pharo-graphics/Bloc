computing styles
transitionStates
	| theStateList parent |
	theStateList := OrderedCollection new.
	parent := self styleable.
	[ parent isNotNil ]
		whileTrue: [ 
			theStateList addFirst: parent pseudoClassStates.
			parent := parent parent ].
	^ theStateList