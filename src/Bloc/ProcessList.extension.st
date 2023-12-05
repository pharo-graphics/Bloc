Extension { #name : 'ProcessList' }

{ #category : '*Bloc' }
ProcessList >> firstOrNil [
	"Answer the first link or nil if the receiver is empty."
^firstLink ifNotNil: [ :fl | fl value ]
]
