keyboard handlers
keystrokeEvent: anEvent
	| aTextEditElement aRope aDelta |

	aTextEditElement := anEvent currentTarget.
	aRope := aTextEditElement text rope.

	anEvent charCode = Character arrowLeft
		ifTrue: [ ^ self moveCursorsLeft: aTextEditElement ].

	anEvent charCode = Character arrowRight
		ifTrue: [ ^ self moveCursorsRight: aTextEditElement ].
		
	anEvent charCode = Character backspace
		ifTrue: [ ^ self ].
	
	aDelta := 0.
	aTextEditElement cursors
		select: #hasParent
		thenDo: [ :aCursor |
			aRope := aRope insertItems: { anEvent charCode } at: aCursor textIndex + aDelta.
			aDelta := aDelta + 1 ].
	
	
	aTextEditElement text: (BrRopedText rope: aRope)