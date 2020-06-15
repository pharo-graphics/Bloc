"
Definition of Ropeable from wordnik.com (from Australia, New Zealand) Angry to the point of needing to be restrained from violent action.

BlRopableCollectionFile looks enough like the Arrays used by BlCollectionRope after the string has been normalised to be used in BlCollectionRope. 

Since the entire file is not read until needed the size is an estimation which is guaranteed to be larger than or equal to the text size (since there are currently no cases in which a single byte from the file is converted to multiple characters / symbols in the resulting text).


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	fileReference:		<Object>
	map:		<SortedCollection> Character index -> Byte index


    Implementation Points
"
Class {
	#name : #BlRopeableCollectionFile,
	#superclass : #Object,
	#instVars : [
		'fileReference',
		'binaryStream',
		'map',
		'bufferSize',
		'buffer',
		'bufferStart',
		'bufferedSize',
		'haveSize'
	],
	#category : #'Bloc-DataStructure - Rope'
}

{ #category : #accessing }
BlRopeableCollectionFile class >> defaultBufferSize [
	"The default number of characters in the receiver's buffer"

	^ 200000
]

{ #category : #'instance creation' }
BlRopeableCollectionFile class >> ropeFor: aFileReference [

	^ BlRopedText rope: (BlCollectionRope collection: (self new fileReference: aFileReference))
]

{ #category : #comparing }
BlRopeableCollectionFile >> = anObject [
	"Compare the contents of the receiver to anObject.
	Beware: this will be slow for large files"

	^ fileReference
		ifNil: [ '' = anObject ]
		ifNotNil: [ fileReference contents = anObject ]
]

{ #category : #accessing }
BlRopeableCollectionFile >> at: anInteger [
	"Answer the character at anInteger"

	self ensureBuffered: anInteger.
	^ buffer at: (anInteger - bufferStart + 1).
]

{ #category : #accessing }
BlRopeableCollectionFile >> bufferSize [
	^ bufferSize
]

{ #category : #accessing }
BlRopeableCollectionFile >> bufferSize: anInteger [

	bufferSize := anInteger.
	buffer := String new: bufferSize.
	bufferStart := nil.
	bufferedSize := 0.
]

{ #category : #private }
BlRopeableCollectionFile >> characterStream [
	"Answer a read stream with character decoding on the receiver's binary stream"

	^ ZnCharacterReadStream 
		on: binaryStream 
		encoding: 'utf8'
]

{ #category : #'initialize-release' }
BlRopeableCollectionFile >> close [

	binaryStream close
]

{ #category : #copying }
BlRopeableCollectionFile >> copyFrom: startIndex to: endIndex [
	| length results receiverIndex bufferIndex resultIndex |

	self ensureBuffered: startIndex.
	length := endIndex - startIndex + 1.
	length <= 0 ifTrue: [ ^ '' ].
	results := Array new: length.
	receiverIndex := startIndex.
	resultIndex := 1.
	bufferIndex := startIndex - bufferStart + 1.

	[ receiverIndex <= endIndex ] whileTrue:
		[ bufferIndex > bufferedSize ifTrue: 
			[ self ensureBuffered: receiverIndex.
			bufferIndex := receiverIndex - bufferStart ].
		results at: resultIndex put: (buffer at: bufferIndex).
		receiverIndex := receiverIndex + 1.
		resultIndex := resultIndex + 1.
		bufferIndex := bufferIndex + 1. ].

	^ results

]

{ #category : #enumerating }
BlRopeableCollectionFile >> do: aBlock [ 
	| characterStream ch |

	fileReference ifNil: [ ^ self ].
	binaryStream position: 0.
	characterStream := self characterStream.
	[ characterStream atEnd ] whileFalse:
		[ ch := characterStream next.
		ch ifNotNil: [ aBlock value: ch ] ]
]

{ #category : #private }
BlRopeableCollectionFile >> ensureBuffered: anInteger [
	"Ensure the character at anInteger is buffered"
	| mapEntry characterStream normalizer rawBuffer |

	((anInteger between: bufferStart and: bufferStart + bufferedSize - 1) and: [ bufferStart > 0 ]) ifTrue: [ ^self ].
	(haveSize and: [ anInteger > self size ]) ifTrue: [ ^self ].

	mapEntry := self mapEntryFor: anInteger.

	binaryStream position: mapEntry value.
	bufferStart := mapEntry key.
	bufferedSize := 0.
	characterStream := self characterStream.
	normalizer := BlTextStringNormalizer new.

	"All of the below should be modified to work with existing collections,
	not discarding and creating on each iteration"

	[ (anInteger > (bufferStart + bufferedSize - 1)) or: [ bufferStart = 0 ] ] whileTrue:
		[ bufferStart := bufferStart + bufferedSize.
		rawBuffer := characterStream next: bufferSize.
		buffer := normalizer process: rawBuffer.
		bufferedSize := buffer size.
		map add: (bufferStart + bufferedSize - 1) -> binaryStream position.
		haveSize := haveSize or: [ binaryStream atEnd ].
		(haveSize and: [ anInteger > self size ]) ifTrue: [ ^self ] ].

]

{ #category : #accessing }
BlRopeableCollectionFile >> fileReference [
	^ fileReference
]

{ #category : #accessing }
BlRopeableCollectionFile >> fileReference: aFileReference [

	binaryStream ifNotNil: [ binaryStream close ].
	fileReference := aFileReference asFileReference.
	binaryStream := fileReference binaryReadStream.
	WeakRegistry default 
		add: self
		executor: (BlRopeableCollectionFileFinalizer new
						binaryStream: binaryStream)
]

{ #category : #comparing }
BlRopeableCollectionFile >> hash [ 
	"Use identity hash to quickly differentiate most objects"

	^ self identityHash
]

{ #category : #accessing }
BlRopeableCollectionFile >> haveSize [
	^ haveSize
]

{ #category : #initialization }
BlRopeableCollectionFile >> initialize [

	super initialize.
	self bufferSize: self class defaultBufferSize.
	map := SortedCollection sortBlock: [ :a :b | a key < b key ].
	map add: 1 -> 0.
	haveSize := false.
	bufferStart := 0.
	bufferedSize := 0.
	
]

{ #category : #'private - testing' }
BlRopeableCollectionFile >> map [
	"Only used for testing"

	^ map
]

{ #category : #private }
BlRopeableCollectionFile >> mapEntryFor: anInteger [
	"Answer the map entry with largest character offset less than or equal to anInteger"
	| left right mid midVal |

	map size = 1 ifTrue: [ ^ map first ].
	map size = 2 ifTrue:
		[ ^ map second key > anInteger
			ifTrue: [ map first ]
			ifFalse: [ map second ]].

	"Modified binary search"
	left := 1.
	right := map size.

	[ left <= right ] whileTrue:
		[ mid := left + ((right - left) // 2).
		midVal := map at: mid.
		anInteger < midVal key ifTrue: 
			[ right := mid - 1 ]
		ifFalse:
			[ anInteger = midVal key
				ifTrue: [ ^ midVal ]
				ifFalse: [ left := mid + 1 ] ] ].

	^ anInteger > midVal key 
		ifTrue: [ midVal ]
		ifFalse: [ map at: mid-1 ]

	"mapEntry := map first.
	index := 2.
	[ index <= map size and: [ (map at: index) key <= anInteger ] ] whileTrue:
		[ mapEntry := map at: index.
		index := index + 1 ]."

]

{ #category : #accessing }
BlRopeableCollectionFile >> size [ 
	"Answer the receiver's size.
	If the entire file has not been scanned use the file size, which will be either correct or an over-estimate"

	^ haveSize
		ifTrue: [ map last key ]
		ifFalse: [ fileReference
			ifNil: [ 0 ]
			ifNotNil: [ fileReference size ] ]
]

{ #category : #private }
BlRopeableCollectionFile >> species [ 
	"Answer a class that can be used to create new in-memory ropes"

	^ String
]
