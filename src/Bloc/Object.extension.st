Extension { #name : #Object }

{ #category : #'*Bloc' }
Object >> entryIdentifier [
	"Answer the object used to identify this task.
	nil = unidentified (and thus can be queued multiple times)"

	^nil
]

{ #category : #'*Bloc' }
Object >> isBlocElementId [

	^ false
]

{ #category : #'*Bloc' }
Object >> ropeAttributeType [
	"Return an object that is used to compare attribute by type
	The rule is the following: attributes of the same type must overwrite each other."
	
	^ self
]
