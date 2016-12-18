layout
validateChildrenOrder
	"I am a class invariant"
	| aLastPosition aLastScreenLocation |
	
	self hasChildren
		ifFalse: [ ^ self ]. 

	aLastPosition := self childPositionOf: (self childAt: 1).
	aLastScreenLocation := self orientation decoratedStart: (self childAt: 1).
	
	shouldReverseLayout
		ifTrue: [ 
			2 to: self childrenCount do: [ :anIndex |
				| anElement aPosition aScreenLocation |
				anElement := self childAt: anIndex.
				aPosition := self childPositionOf: anElement.
				aScreenLocation := self orientation decoratedStart: anElement.
				aPosition < aLastPosition
					ifTrue: [ self error: 'Detected invalid position!' ].
				aScreenLocation > aLastScreenLocation
					ifTrue: [ self error: 'Detected invalid location!' ] ] ]
		ifFalse: [ 
			2 to: self childrenCount do: [ :anIndex |
				| anElement aPosition aScreenLocation |
				anElement := self childAt: anIndex.
				aPosition := self childPositionOf: anElement.
				aScreenLocation := self orientation decoratedStart: anElement.
				aPosition < aLastPosition
					ifTrue: [ self error: 'Detected invalid position!' ].
				aScreenLocation < aLastScreenLocation
					ifTrue: [ self error: 'Detected invalid location!' ] ] ]