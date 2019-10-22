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
BlRopedRawText >> insertString: aString at: anIndex [
	self insertItems: aString at: anIndex.
	self notifyStringInserted: aString at: anIndex
]

{ #category : #'text - converting' }
BlRopedRawText >> normalized [
	^ BlRopedText rope: (self rope replaceAll: ({
			BlTextLineEndingMacClassic .
			BlTextLineEndingUnix .
			BlTextLineEndingWindows .
			BlTextTab
		} collect: [ :eachItemClass | eachItemClass uniqueInstance asString -> { eachItemClass uniqueInstance } ]))
]
