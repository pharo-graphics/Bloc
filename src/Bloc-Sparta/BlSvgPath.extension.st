Extension { #name : #BlSvgPath }

{ #category : #'*Bloc-Sparta' }
BlSvgPath >> buildPathOnSpartaCanvas: aCanvas [
	| pathBuilder|

	pathBuilder := aCanvas path.
	segments do: [ :each |  each executeOn: pathBuilder ].
	^ pathBuilder finish
]
