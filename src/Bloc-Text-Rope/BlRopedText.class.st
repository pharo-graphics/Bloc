"
I am a concrete implementation of a text model backed up by a persistent rope data structure.

See `BlText` for more information.
See `BlRope` to learn more about rope

"
Class {
	#name : #BlRopedText,
	#superclass : #BlText,
	#instVars : [
		'rope',
		'attributesFinder'
	],
	#category : #'Bloc-Text-Rope-Text'
}

{ #category : #'instance creation' }
BlRopedText class >> file: aFileReference [
	<return: #BlRopedText>

	^ self rope: (BlCollectionRope collection: (BlRopeableCollectionFile new fileReference: aFileReference))
]

{ #category : #'instance creation' }
BlRopedText class >> items: aCollectionOfItems [
	<return: #BlRopedText>

	^ self rope: (BlCollectionRope collection: aCollectionOfItems)
]

{ #category : #'instance creation' }
BlRopedText class >> rope: aRope [
	^ self new
		initializeWith: aRope;
		yourself
]

{ #category : #'instance creation' }
BlRopedText class >> string: aString [
	"Take the supplied string like object, convert it to a normalised string and answer as roped text"
	<return: #BlRopedText>

	^ self rope: (BlCollectionRope collection: aString)
]

{ #category : #'text - converting' }
BlRopedText >> asRopedText [
	^ self
]

{ #category : #'text - accessing' }
BlRopedText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>

	^ self rope at: anIndex
]

{ #category : #'text - attributes' }
BlRopedText >> attributes: anAttributesCollection [

	| aNewRope |
	aNewRope := rope attributes: anAttributesCollection.
	aNewRope == rope ifTrue: [ ^ self ].

	self rope: aNewRope.

	anAttributesCollection do: [ :eachAttribute | 
		self
			notifyAttributeAdded: eachAttribute
			from: (1 min: aNewRope size)
			to: aNewRope size ]
]

{ #category : #'text - attributes' }
BlRopedText >> attributes: anAttributesCollection from: aFromIndex to: aToIndex [
	| aNewRope |
	
	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ self isNotEmpty or: [ aFromIndex = 1 and: [ aToIndex isZero ] ] ]
		description: [ 'If I am empty then start must be 1 and end must be zero' ].
	
	aNewRope := rope attributes: anAttributesCollection from: ((aFromIndex - 1) max: 0) to: (aToIndex min: self size).	
	aNewRope == rope
		ifTrue: [ ^ self ].
	
	self rope: aNewRope.
	
	anAttributesCollection do: [ :eachAttribute |
		self notifyAttributeAdded: eachAttribute from: aFromIndex to: aToIndex ]
]

{ #category : #'text - attributes' }
BlRopedText >> attributesFinder [
	^ attributesFinder ifNil: [ attributesFinder := BlTextAttributesCachingFinder new initializeForText: self ]
]

{ #category : #'text - attributes' }
BlRopedText >> clearAttributes: aFromIndex to: aToIndex if: aBlock [
	| aNewRope |
	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].
	
	aNewRope := rope clearAttributes: ((aFromIndex - 1) max: 0) to: aToIndex if: aBlock.
	aNewRope == rope
		ifTrue: [ ^ self ].
	
	self rope: aNewRope.
	self notifyAttributesRemovedFrom: aFromIndex to: aToIndex
]

{ #category : #'text - copying' }
BlRopedText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.

	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."
	<return: #BlText>

	aStartIndex > anEndIndex
		ifTrue: [ ^ self empty ].

	^ self class rope: (self rope from: ((aStartIndex - 1) max: 0) to: anEndIndex)
]

{ #category : #'text - modifications' }
BlRopedText >> deleteAll: aCollectionOfIntervals [
	"Intervals must not overlap!"
	| theDeletedTexts aRope theUpdatedIntervals |
	
	theDeletedTexts := aCollectionOfIntervals
		collect: [ :eachInterval | self copyFrom: eachInterval first to: eachInterval last ].
	
	aRope := rope.
	
	theUpdatedIntervals := aCollectionOfIntervals collect: #copy.
	
	theUpdatedIntervals
		do: [ :eachCurrentDeletionInterval |
			aRope := aRope delete: ((eachCurrentDeletionInterval first - 1) max: 0) to: eachCurrentDeletionInterval last.
	
			1 to: theUpdatedIntervals size do: [ :eachIntervalIndex |
				| aCurrentIntervalToUpdate |
			
				aCurrentIntervalToUpdate := theUpdatedIntervals at: eachIntervalIndex.
				
				aCurrentIntervalToUpdate first > eachCurrentDeletionInterval last
					ifTrue: [
						theUpdatedIntervals
							at: eachIntervalIndex
							put: (
								(aCurrentIntervalToUpdate first - eachCurrentDeletionInterval size)
								to: (aCurrentIntervalToUpdate last - eachCurrentDeletionInterval size)) ] ] ].
	
	rope := aRope.
	self
		notifyDeletedAll: theUpdatedIntervals
		requested: aCollectionOfIntervals
		texts: theDeletedTexts
]

{ #category : #'text - enumeration' }
BlRopedText >> do: aBlock [
	self rope do: aBlock
]

{ #category : #'text - accessing' }
BlRopedText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>
	
	^ self class string: ''
]

{ #category : #'text - converting' }
BlRopedText >> encodeOn: aWriteStream with: aZnCharacterEncoder [
	"Encode my rope on a ByteStream using the provided Zinc encoder."

	rope encodeOn: aWriteStream with: aZnCharacterEncoder
]

{ #category : #'text - enumeration' }
BlRopedText >> from: aFromIndex to: aToIndex do: aBlock [

	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ 'Start must not exceed end' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	self rope
		from: ((aFromIndex - 1) max: 0)
		to: aToIndex
		do: aBlock
]

{ #category : #'text - copying' }
BlRopedText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self rope
]

{ #category : #initialization }
BlRopedText >> initialize [
	super initialize.
	
	attributesFinder := nil
]

{ #category : #initialization }
BlRopedText >> initializeWith: aRope [
	rope := aRope.
	attributesFinder := nil
]

{ #category : #'text - modifications' }
BlRopedText >> insertItems: aCollectionOfCollectionsOfItems atAll: aCollectionOfIndices [
	"I return actual indices after insertion"
	<return: #Collection of: #Number>
	| theUpdatedIndices aRope aCurrentItemsIndex |
	
	aRope := rope.
	
	theUpdatedIndices := aCollectionOfIndices copy.
	
	aCurrentItemsIndex := 0.
	aCollectionOfCollectionsOfItems
		with: theUpdatedIndices
		do: [ :eachCollection :eachCurrentInsertionIndex |
			aRope := aRope insertItems: eachCollection at: eachCurrentInsertionIndex.
	
			aCurrentItemsIndex := aCurrentItemsIndex + 1.
			1 to: theUpdatedIndices size do: [ :each |
				| aCurrentIndexToUpdate |
				aCurrentIndexToUpdate := theUpdatedIndices at: each.
				(aCurrentIndexToUpdate >= eachCurrentInsertionIndex and: [ aCurrentItemsIndex ~= each ])
					ifTrue: [
						theUpdatedIndices
							at: each
							put: (aCurrentIndexToUpdate + eachCollection size) ] ] ].
	rope := aRope.
	^ theUpdatedIndices
]

{ #category : #'text - modifications' }
BlRopedText >> insertStrings: aCollectionOfStrings atAll: aCollectionOfIndices [
	self
		notifyStringsInserted: aCollectionOfStrings
		atAll: (self
			insertItems: aCollectionOfStrings
			atAll: aCollectionOfIndices)
		requested: aCollectionOfIndices
]

{ #category : #accessing }
BlRopedText >> insertText: aBlText at: anIndex [

	rope := rope insert: aBlText rope at: anIndex.
	self
		notifyStringsInserted: { aBlText characters asString }
		atAll: { anIndex }
		requested: { anIndex }
]

{ #category : #copying }
BlRopedText >> internalRepresentation [

	^ self rope
]

{ #category : #'text - testing' }
BlRopedText >> isEmpty [

	^ self rope size = 0
]

{ #category : #'text - enumeration' }
BlRopedText >> iterator [
	"Return an iterator pointing to the first text item (character)"

	^ BlRopedTextIterator text: self
]

{ #category : #'text - enumeration' }
BlRopedText >> iterator: aFromIndex to: aToIndex [
	"Return an iterator pointing to the anStartIndex text item (character) limited by anEndIndex"
	<return: #BlTextIterator>
	
	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: [ 'Start must not exceed end more than by one' ].

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	^ BlRopedTextIterator text: self from: aFromIndex to: aToIndex
]

{ #category : #accessing }
BlRopedText >> rope [
	^ rope
]

{ #category : #accessing }
BlRopedText >> rope: aBlRope [
	self initializeWith: aBlRope
]

{ #category : #'text - accessing' }
BlRopedText >> size [
	^ self rope size
]

{ #category : #'text - printing' }
BlRopedText >> storeOn: aStream [
	| anIterator allPieces attributesMap bindingsMap |
		
	anIterator := self iterator.
	
	allPieces := Array streamContents: [ :anArrayStream |
		[ anIterator hasNext ] whileTrue: [
			| aSpan aSpanIterator aDelta |
			aDelta := anIterator position.
			aSpan := anIterator nextSpan.
			aSpanIterator := aSpan iterator.
			[ aSpanIterator hasNext ] whileTrue: [
				aSpanIterator
					nextAttributedEnd: [ :eachAttribute | true ]
					indicesDo: [ :aStart :anEnd :theAttributes |
						anArrayStream nextPut: { aStart + aDelta . anEnd + aDelta . theAttributes }  ] ] ] ].
	
	attributesMap := (allPieces flatCollect: [ :eachTuple | eachTuple last ])
		groupedBy: [ :eachAttribute | eachAttribute ]
		having: [ :eachGroup | eachGroup size > 1 ].
	attributesMap := attributesMap collect: #size.

	attributesMap := attributesMap associations groupedBy: [ :eachAssociation | eachAssociation key class ].
	bindingsMap := IdentityDictionary new.

	attributesMap keysAndValuesDo: [ :eachClass :theAttributes |
		theAttributes withIndexDo: [ :eachAttribute :eachIndex |
			bindingsMap at: eachAttribute key put: 'a', eachClass name, eachIndex asString ] ].

	bindingsMap keysAndValuesDo: [ :eachAttribute :eachVariableName |
		aStream nextPutAll: eachVariableName.
		aStream nextPutAll: ' := '.
		aStream store: eachAttribute.
		aStream nextPut: $. ; cr ].
	
	allPieces withIndexDo: [ :eachTuple :anIndex |
		anIndex > 1
			ifTrue: [ aStream nextPutAll: ', '; cr ].
		
		aStream
			nextPut: $(;
			nextPut: $';
			nextPutAll: ((self from: eachTuple first to: eachTuple second) asString copyReplaceAll: $' asString with: '''''');
			nextPut: $';
			space;
			nextPutAll: #asRopedText asString.
		
		eachTuple third ifNotEmpty: [ :theAttributes |
			aStream
				space;
				nextPutAll: #attributes: asString;
				space.
			aStream nextPut: ${; cr.
			theAttributes
				do: [ :eachAttribute |
					aStream tab.
					
					aStream nextPutAll: (bindingsMap
						at: eachAttribute
						ifAbsent: [ eachAttribute storeString ]) ]
				separatedBy: [ aStream nextPut: $.; cr ].
			aStream cr; nextPut: $} ].
		aStream nextPut: $)
	]
]

{ #category : #copying }
BlRopedText >> takeInternalRepresentationOf: anotherText [

" To be used with caution because the receiver and the argument text must have the same internal representation - another text must be a kind of roped text "
	self rope: anotherText internalRepresentation
]

{ #category : #'text - attributes' }
BlRopedText >> unstyle: aFromIndex to: aToIndex [
	"aFromIndex should be <= than aToIndex"
	<return: #BlText>
	| anUnstyledRope aPreviousRope |

	self
		assert: [ aFromIndex > 0 or: [ aFromIndex = 0 and: [ aToIndex = 0 ] ] ]
		description: [ 'Start and end must be positive or both zero' ].

	aPreviousRope := rope.

	"First refer original rope to support multithreading"
	anUnstyledRope := rope.
	anUnstyledRope := anUnstyledRope
		clearAttributes: ((aFromIndex - 1) max: 0)
		to: aToIndex
		if: [ :anAttribute | anAttribute isOverwritableByStyler ].
	
	self rope: anUnstyledRope.
	
	aPreviousRope == anUnstyledRope
		ifFalse: [ self notifyAttributesRemovedFrom: aFromIndex to: aToIndex ]
]
