keyboard handlers
keystrokeEvent: anEvent
	| aTextEditElement aRope |

	aTextEditElement := anEvent currentTarget.
	aRope := aTextEditElement text rope.

	anEvent charCode = Character arrowLeft
		ifTrue: [ ^ self moveCursorsLeft: aTextEditElement ].

	anEvent charCode = Character arrowRight
		ifTrue: [ ^ self moveCursorsRight: aTextEditElement ].
	
	"aRope := aRope insertItems: { anEvent charCode } at: cursor textIndex.
	aTextEditElement text: (BrRopedText rope: aRope)"