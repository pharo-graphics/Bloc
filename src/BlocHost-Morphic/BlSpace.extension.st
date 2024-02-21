Extension { #name : #BlSpace }

{ #category : #'*BlocHost-Morphic' }
BlSpace >> showNotification: aNotification [

	self root showNotification: aNotification
]

{ #category : #'*BlocHost-Morphic' }
BlSpace >> useMorphicHost [
	
	self host: BlMorphicWindowHost new
]
