Class {
	#name : #BlRopedRawText,
	#superclass : #BlRopedText,
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlRopedRawText class >> string: aString [
	<return: #BlRopedText>

	^ self rope: (BlCollectionRope collection: aString)
]

{ #category : #'text - converting' }
BlRopedRawText >> asRopedText [
	^ self normalized
]

{ #category : #'text - modifications' }
BlRopedRawText >> insertStrings: aCollectionOfStrings atAll: aCollectionOfIndices [
	self
		notifyStringsInserted: aCollectionOfStrings
		atAll: (self
			insertItems: aCollectionOfStrings
			atAll: aCollectionOfIndices)
		requested: aCollectionOfIndices
]

{ #category : #'text - converting' }
BlRopedRawText >> normalized [
	
	^ BlRopedText string: rope
]
