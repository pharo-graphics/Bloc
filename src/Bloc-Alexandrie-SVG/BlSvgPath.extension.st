Extension { #name : #BlSvgPath }

{ #category : #'*Bloc-Alexandrie-SVG' }
BlSvgPath >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext | self aeBuildPathOn: cairoContext ]
]

{ #category : #'*Bloc-Alexandrie-SVG' }
BlSvgPath >> aeBuildPathOn: cairoContext [
	"Build my path, with my fill rule, on cairoContext. Used both to draw me and to hit test me."

	fillRule = Winding
		ifTrue: [ cairoContext useFillRuleWinding ]
		ifFalse: [ cairoContext useFillRuleEvenOdd ].
	self flag: #todo. "Don't parse again each time"
	(BlSvgPathParser
		on: pathString readStream
		handler: (BASvgPathDrawHandler on: cairoContext))
		readUpToEnd
]

{ #category : #'*Bloc-Alexandrie-SVG' }
BlSvgPath >> aeContainsPoint: aPoint strokeWidth: aNumber [
	"Answer whether aPoint is in my fill or in my stroke of width aNumber.
	Cairo answers it on a scratch context holding the same path as the one drawn."

	| context |
	context := (AeCairoImageSurface extent: 1 @ 1) newContext.
	self aeBuildPathOn: context.
	(context isInFillX: aPoint x y: aPoint y) ifTrue: [ ^ true ].
	aNumber > 0 ifFalse: [ ^ false ].
	context strokeSize: aNumber.
	^ context isInStrokeX: aPoint x y: aPoint y
]

{ #category : #'*Bloc-Alexandrie-SVG' }
BlSvgPath >> hasCaps [
	"The purpose of answering false is optimization. For a simplified implementation, always set caps."

	^ true
]

{ #category : #'*Bloc-Alexandrie-SVG' }
BlSvgPath >> hasJoins [
	"The purpose of answering false is optimization. For a simplified implementation, always set joins."

	^ true
]
