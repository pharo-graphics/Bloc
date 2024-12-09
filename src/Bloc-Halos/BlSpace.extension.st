Extension { #name : #BlSpace }

{ #category : #'*Bloc-Halos' }
BlSpace >> addHalosListener2 [

	self root addEventFilter: BlSpaceHalosEventListener new
]
