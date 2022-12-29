Extension { #name : #BlSpace }

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> aeAsForm [

	^ self root aeAsForm
]

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> aeDrawOn: aeCanvas [

	self root aeFullDrawOn: aeCanvas
]
