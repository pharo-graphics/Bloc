Extension { #name : #BlShadowEffect }

{ #category : #'*Bloc-Alexandrie' }
BlShadowEffect >> aeDrawAbove: aBlElement on: aeCanvas [ 

	isInset ifTrue: [ self aeDrawInset: aBlElement on: aeCanvas ]
		
]

{ #category : #'*Bloc-Alexandrie' }
BlShadowEffect >> aeDrawBelow: aBlElement on: aeCanvas [

	isInset ifFalse: [ self aeDrawOutset: aBlElement on: aeCanvas ]

]

{ #category : #'*Bloc-Alexandrie' }
BlShadowEffect >> aeDrawInset: aBlElement on: aeCanvas [

	self subclassResponsibility
]

{ #category : #'*Bloc-Alexandrie' }
BlShadowEffect >> aeDrawOutset: aBlElement on: aeCanvas [

	self subclassResponsibility
]
