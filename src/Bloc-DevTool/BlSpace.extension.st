Extension { #name : #BlSpace }

{ #category : #'*Bloc-DevTool' }
BlSpace >> withHalos [
	self root
		when: BlMouseDownEvent
		do: [ :evt | (evt modifiers isShift and: [ evt modifiers isAlt ])
			ifTrue: [ BlElementSelection on: evt target ] ]
]
