Extension { #name : #BlSvgPath }

{ #category : #'*Bloc-Alexandrie' }
BlSvgPath >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		fillRule = Winding
			ifTrue: [ cairoContext useFillRuleWinding ]
			ifFalse: [ cairoContext useFillRuleEvenOdd ].

		(BlSvgPathParser
			on: svgPathString readStream
			handler: (BASvgPathDrawHandler on: cairoContext))
			readUpToEnd ]
]

{ #category : #'*Bloc-Alexandrie' }
BlSvgPath >> hasCaps [
	"The purpose of answering false is optimization. For a simplified implementation, always set caps."

	^ true
]

{ #category : #'*Bloc-Alexandrie' }
BlSvgPath >> hasJoins [
	"The purpose of answering false is optimization. For a simplified implementation, always set joins."

	^ true
]
