Extension { #name : #BlSpace }

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> aeAsForm [

	self
		deprecated: 'Send #aeAsForm to my root instead'
		transformWith: '`@rcv aeAsForm' -> '`@rcv root aeAsForm'.
	
	^ self root aeAsForm
]

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> aeFullDrawOn: aeCanvas [

	self root aeFullDrawOn: aeCanvas

]
