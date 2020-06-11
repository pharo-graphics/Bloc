Class {
	#name : #BlInfiniteExampleTextFileDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'textFile',
		'textChunks'
	],
	#category : #'Bloc-Examples-Infinite Files'
}

{ #category : #initialization }
BlInfiniteExampleTextFileDataSource >> initialize [
	super initialize.
	
	textChunks := OrderedCollection new
]

{ #category : #accessing }
BlInfiniteExampleTextFileDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ textChunks size
]

{ #category : #'instance creation' }
BlInfiniteExampleTextFileDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"
	
	aPosition >= textChunks size
		ifTrue: [
			| allLines  |
					
			allLines := textFile contents lines.
			
			aPosition < allLines size
				ifTrue: [
					| newLines |
					
					newLines := allLines copyFrom: textChunks size + 1 to: ((textChunks size + 10) min: allLines size).
			
					textChunks addAll: newLines.
					self notifyItemsInserted: (aPosition + 1 to: aPosition + newLines size) ] ].

	anElementHolder textChunk: (textChunks at: aPosition)
]

{ #category : #'instance creation' }
BlInfiniteExampleTextFileDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	"Override to create an ElementHolder for an item type.
	use ===BlElementHolder of: element=== to create a holder for an element".

	^ BlInfiniteExampleTextFileChunkElementHolder new
]

{ #category : #accessing }
BlInfiniteExampleTextFileDataSource >> textFile [
	^ textFile
]

{ #category : #accessing }
BlInfiniteExampleTextFileDataSource >> textFile: aFileReference [
	textChunks removeAll.

	textFile := aFileReference.

	textChunks := (aFileReference contents lines first: 10) asOrderedCollection.

	self notifyChanged
]
