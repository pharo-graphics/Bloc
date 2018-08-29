Extension { #name : #BlockClosure }

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> asCommand [
	^ BlValuableCommand new valuable: self
]
