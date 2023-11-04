Extension { #name : 'BlSvgPath' }

{ #category : '*Bloc-Alexandrie-SVG' }
BlSvgPath >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		fillRule = Winding
			ifTrue: [ cairoContext useFillRuleWinding ]
			ifFalse: [ cairoContext useFillRuleEvenOdd ].

		self flag: #todo. "Don't parse again each time"
		(BlSvgPathParser
			on: pathString readStream
			handler: (BASvgPathDrawHandler on: cairoContext))
			readUpToEnd ]
]

{ #category : '*Bloc-Alexandrie-SVG' }
BlSvgPath >> hasCaps [
	"The purpose of answering false is optimization. For a simplified implementation, always set caps."

	^ true
]

{ #category : '*Bloc-Alexandrie-SVG' }
BlSvgPath >> hasJoins [
	"The purpose of answering false is optimization. For a simplified implementation, always set joins."

	^ true
]
