"
Definition of Ropeable from wordnik.com (from Australia, New Zealand) Angry to the point of needing to be restrained from violent action.

BlRopableCollectionFile looks enough like the Strings used by BlCollectionRope after the string has been normalised to be used in BlCollectionRope. 

Since the entire file is not read until needed the size is an estimation which is guaranteed to be larger than or equal to the text size (since there are currently no cases in which a single byte from the file is converted to multiple characters / symbols in the resulting text).

The default behaviour is to interpret the file as UTF-8 encoded.  If an encoding error is encountered, the remainder of the file is interpreted as ascii (null-encoding).

The read stream on the receiver's file is automatically closed when the receiver is garbage collected.


Public API and Key Messages

- ropeFor: 		Answer a BlRopedText on the supplied file.


## Internal Representation and Key Implementation Points.

### Instance Variables

	binaryStream: 		<ZnBufferedReadStream> The underlying stream for the receiver's file.
	bufferSize: 			<Integer> See implementation notes
	buffer: 				<String> See implementation notes
	bufferStart: 		<Integer> The character offset of the first character in the buffer
	bufferedSize: 		<Integer> The number of valid characters in the buffer
	fileReference:		<FileReference> The file being read
	haveSize: 			<Boolean> True if the actual character size of the file is known
	map:					<SortedCollection> Character index -> Byte index
	strict: 				<Boolean> If true, an exception will be raised when decoding the file (UTF-8).  If false, the character stream will be interpreted as ascii (null-encoding).


### Implementation Points

#### Buffer Efficiency

Currently characters are read from the stream using #next:, creating a new buffer object each time the file is read.  Performance can be improved by re-using a single buffer and reading in to it (thus bufferedSize).

#### size 

The #size method currently returns an estimate of the actual size is not known.  This can cause problems if a user attempts to copy the entire contents using `text size` as the end position.

Probably size should be reified and a StringSize object used to indicate the end of the string.  However it isn't clear how comparisons with numbers should be performed, and no exceptions have actually occurred, so this has been deferred until an actual case can be analysed.

Once that has been done, #size should be modified to raise an exception if the actual size isn't known.  #approximateSize can be used to get an idea of the receiver's size.

"
Class {
	#name : #BlRopeableCollectionFile,
	#superclass : #Object,
	#instVars : [
		'fileReference',
		'strict',
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

{ #category : #comparing }
BlRopeableCollectionFile >> = anObject [
	"Compare the contents of the receiver to anObject.
	Beware: this will be slow for large files"

	^ fileReference
		ifNil: [ '' = anObject ]
		ifNotNil: [ fileReference contents = anObject ]
]

{ #category : #accessing }
BlRopeableCollectionFile >> approximateSize [ 
	"Answer the receiver's size, if known.   If not use the file size, which will be either correct or an over-estimate"

	^ haveSize
		ifTrue: [ map last key ]
		ifFalse: [ fileReference
			ifNil: [ 0 ]
			ifNotNil: [ fileReference size ] ]
]

{ #category : #accessing }
BlRopeableCollectionFile >> at: anInteger [
	"Answer the character at anInteger"

	self ensureBuffered: anInteger.
	^ buffer at: (anInteger - bufferStart + 1) asInteger.
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
	results := String new: length.
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

{ #category : #copying }
BlRopeableCollectionFile >> copyToEndFrom: startIndex [
	"Copy the receiver's contents from startIndex to the end.
	This should be used instead of #copyFrom:to: since the receiver's length may not be known."
	| length results receiverIndex bufferIndex resultIndex endIndex |

	self ensureBuffered: startIndex.
	endIndex := self approximateSize.
	length := endIndex - startIndex + 1.
	length <= 0 ifTrue: [ ^ '' ].
	results := Array new: length.
	receiverIndex := startIndex.
	resultIndex := 1.
	bufferIndex := startIndex - bufferStart + 1.

	[ receiverIndex <= endIndex ] whileTrue:
		[ bufferIndex > bufferedSize ifTrue: 
			[ self ensureBuffered: receiverIndex.
			bufferIndex := receiverIndex - bufferStart.
			endIndex := self approximateSize ].
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
	| mapEntry characterStream rawBuffer |

	((anInteger between: bufferStart and: bufferStart + bufferedSize - 1) and: [ bufferStart > 0 ]) ifTrue: [ ^self ].
	(haveSize and: [ anInteger > self size ]) ifTrue: [ ^self ].

	mapEntry := self mapEntryFor: anInteger.

	binaryStream position: mapEntry value.
	bufferStart := mapEntry key.
	bufferedSize := 0.
	characterStream := self characterStream.

	"All of the below should be modified to work with existing collections,
	not discarding and creating on each iteration"

	[ (anInteger > (bufferStart + bufferedSize - 1)) or: [ bufferStart = 0 ] ] whileTrue:
		[ bufferStart := bufferStart + bufferedSize.
		rawBuffer := self loadNext: bufferSize with: characterStream.
		buffer := rawBuffer.
		bufferedSize := buffer size.
		map add: (bufferStart + bufferedSize - 1) -> binaryStream position.
		haveSize := haveSize or: [ binaryStream atEnd ].
		(haveSize and: [ anInteger >= self size ]) ifTrue: [ ^self ] ].

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
		finalizer:
		(BlRopeableCollectionFileFinalizer new binaryStream: binaryStream)
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
	strict := false.
	
]

{ #category : #private }
BlRopeableCollectionFile >> loadNext: aNumber with: aReadStream [
	"Answer the next aNumber characters using aReadstream.
	If an encoding error occurs and strict is false, fall back to null encoding"
	| startPosition |

	startPosition := binaryStream position.
	^ [ aReadStream next: aNumber ]
		on: ZnCharacterEncodingError
		do: [ :ex | 
			strict ifTrue: 
				[ ex pass ]
			ifFalse:
				[ binaryStream position: startPosition.
				self loadNext: aNumber with: self nullEncodedStream ] ]
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

{ #category : #private }
BlRopeableCollectionFile >> nullEncodedStream [
	"Answer a read stream with null (ascii) character decoding on the receiver's binary stream"

	^ ZnCharacterReadStream 
		on: binaryStream 
		encoding: 'null'
]

{ #category : #accessing }
BlRopeableCollectionFile >> size [ 
	"Answer the receiver's size.
	If the entire file has not been scanned use the file size, which will be either correct or an over-estimate"

	"Ensure that the initial buffer has been loaded, which will improve accuracy in many cases"
	bufferedSize = 0 ifTrue: 
		[ fileReference size = 0 ifTrue: [ ^ 0 ].
		self ensureBuffered: 1 ].

	^ haveSize
		ifTrue: [ map last key ]
		ifFalse: [ BlTextIndexEOS new text: self ]
]

{ #category : #private }
BlRopeableCollectionFile >> species [ 
	"Answer a class that can be used to create new in-memory ropes"

	^ String
]

{ #category : #accessing }
BlRopeableCollectionFile >> strict [
	^ strict
]

{ #category : #accessing }
BlRopeableCollectionFile >> strict: anObject [
	strict := anObject
]
