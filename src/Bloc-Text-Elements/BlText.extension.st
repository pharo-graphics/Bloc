Extension { #name : #BlText }

{ #category : #'*Bloc-Text-Elements' }
BlText >> asElement [

	^ BlTextElement new
		  text: self;
		  constraintsDo: [ :c | 
			  c horizontal fitContent.
			  c vertical fitContent ];
		  yourself
]
