Extension { #name : #BlSpace }

{ #category : #'*Bloc-Halos' }
BlSpace >> addHalosListenerNewPrototype [

	self root addEventFilter: BlSpaceHalosEventListenerNewPrototype new
]
