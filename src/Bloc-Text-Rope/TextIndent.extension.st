Extension { #name : #TextIndent }

{ #category : #'*Bloc-Text-Rope' }
TextIndent >> applyToBlText: aBlText [

	aBlText paragraphMargin: (BlInsets left: 20*amount)

]
