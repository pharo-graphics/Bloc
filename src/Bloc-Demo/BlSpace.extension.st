Extension { #name : #BlSpace }

{ #category : #'*Bloc-Demo' }
BlSpace >> addHalosListenerNewPrototype [

	self root addEventFilter: BlSpaceHalosEventListenerNewPrototype new
]
