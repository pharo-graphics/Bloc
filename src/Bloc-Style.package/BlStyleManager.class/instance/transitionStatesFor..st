as yet unclassified
transitionStatesFor: aNode
	| parent states |
	states := OrderedCollection new.
	parent := aNode.
	[ parent isNotNil ]
		whileTrue:[ 
			states add: parent pseudoClassStates.
			parent := parent parent].
	^ states  