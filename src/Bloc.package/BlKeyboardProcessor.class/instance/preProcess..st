as yet unclassified
preProcess: anEvent
	| aTarget |
	aTarget := self space focusProcessor lastFocusOwner.
	aTarget ifNil: [ aTarget := self space root ].
	anEvent target: aTarget.
	self fireEvent: anEvent