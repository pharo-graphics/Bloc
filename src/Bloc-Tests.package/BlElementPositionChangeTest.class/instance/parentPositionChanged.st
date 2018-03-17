tests
parentPositionChanged
	<gtExample>
	|
		parent parentPositionChangedListener parentPositionInSpaceChangedListener parentPositionChanged parentPositionInSpaceChanged
		child childPositionChangedListener childPositionInSpaceChangedListener childPositionChanged childPositionInSpaceChanged
		subChild subChildPositionChangedListener subChildPositionInSpaceChangedListener subChildPositionChanged subChildPositionInSpaceChanged
	|

	parentPositionChanged := parentPositionInSpaceChanged := 0.
	childPositionChanged := childPositionInSpaceChanged := 0.
	subChildPositionChanged := subChildPositionInSpaceChanged := 0.

	parent := self elementTree.
	parent forceLayout.
	
	child := parent children first.
	subChild := child children first.
	
	parentPositionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [ parentPositionChanged := parentPositionChanged + 1 ].
	parentPositionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [ parentPositionInSpaceChanged := parentPositionInSpaceChanged + 1 ].
		
	childPositionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [ childPositionChanged := childPositionChanged + 1 ].
	childPositionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [ childPositionInSpaceChanged := childPositionInSpaceChanged + 1 ].
		
	subChildPositionChangedListener := BlEventHandler
		on: BlElementPositionChangedEvent
		do: [ subChildPositionChanged := subChildPositionChanged + 1 ].
	subChildPositionInSpaceChangedListener := BlEventHandler
		on: BlElementPositionInSpaceChangedEvent
		do: [ subChildPositionInSpaceChanged := subChildPositionInSpaceChanged + 1 ].
	
	self assert: parent position equals: 0@0.
	self assert: child position equals: 0@0.
	self assert: subChild position equals: 0@0.
	
	parent addEventHandler: parentPositionChangedListener.
	parent addEventHandler: parentPositionInSpaceChangedListener.
	
	child addEventHandler: childPositionChangedListener.
	child addEventHandler: childPositionInSpaceChangedListener.
	
	subChild addEventHandler: subChildPositionChangedListener.
	subChild addEventHandler: subChildPositionInSpaceChangedListener.
	
	"change parent's position directy directly"
	parent position: 50@50 extent: parent extent.
	
	"notify changed"
	parent commitChanges.

	self assert: parent position equals: 50@50.
	self assert: parentPositionChanged equals: 1.
	self assert: parentPositionInSpaceChanged equals: 1.
	
	self assert: child position equals: 0@0.
	self assert: childPositionChanged equals: 0.
	self assert: childPositionInSpaceChanged equals: 1.
	
	self assert: subChild position equals: 0@0.
	self assert: subChildPositionChanged equals: 0.
	self assert: subChildPositionInSpaceChanged equals: 1.
	
	parent removeEventHandler: parentPositionChangedListener.
	parent removeEventHandler: parentPositionInSpaceChangedListener.
	
	child removeEventHandler: childPositionChangedListener.
	child removeEventHandler: childPositionInSpaceChangedListener.
	
	subChild removeEventHandler: subChildPositionChangedListener.
	subChild removeEventHandler: subChildPositionInSpaceChangedListener.
	
	parent position: 0@0 extent: parent extent.
	
	^ parent