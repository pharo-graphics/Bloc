Extension { #name : #ProcessList }

{ #category : #'*Bloc' }
ProcessList >> firstOrNil [
	"Answer the first link or nil if the receiver is empty."

	self deprecated: 'To be removed'.

	^ firstLink ifNotNil: [ :fl | fl value ]
]
