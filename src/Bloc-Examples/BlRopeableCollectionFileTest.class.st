Class {
	#name : #BlRopeableCollectionFileTest,
	#superclass : #TestCase,
	#instVars : [
		'largeFile'
	],
	#category : #'Bloc-Examples-Rope'
}

{ #category : #private }
BlRopeableCollectionFileTest >> deleteLargeFile [

	largeFile ifNotNil: 
		[ largeFile ensureDelete.
		largeFile := nil ].
]

{ #category : #'test seed' }
BlRopeableCollectionFileTest >> emptyFile [
	
	^ (FileSystem memory root / 'empty.file') ensureCreateFile 
]

{ #category : #'test seed' }
BlRopeableCollectionFileTest >> largeFile [

	^ largeFile ifNil: [
		largeFile := FileSystem memory / 'test.txt'.
		largeFile writeStreamDo: [ :stream |
			1 to: 10000 do: [ :l |
				1 to: 9 do: [ :i |
					stream << (((l-1)*10 + i-1) printPaddedWith: $0 to: 10) ].
				stream << 'abcdefghi'; lf. ] ].
		largeFile ]
]

{ #category : #'test seed' }
BlRopeableCollectionFileTest >> rope [

	^ BlRopedText rope: (BlCollectionRope collection: self ropeableCollection)
]

{ #category : #'test seed' }
BlRopeableCollectionFileTest >> ropeableCollection [

	^ BlRopeableCollectionFile new fileReference: self largeFile
]

{ #category : #tests }
BlRopeableCollectionFileTest >> testAt [

	self 
		assert: (self ropeableCollection at: 1)
		equals: $0.
	self 
		assert: (self ropeableCollection at: 20)
		equals: $1.
	self
		assert: (self ropeableCollection at: 321456)
		equals: $3.
	self
		assert: (self ropeableCollection at: 654400)
		equals: Character lf.
	self deleteLargeFile

]

{ #category : #tests }
BlRopeableCollectionFileTest >> testCopyFromTo [

	| expected |
	self 
		assert: (self ropeableCollection copyFrom: 1 to: 10)
		equals: '0000000000'.
	expected := 'efghi', String lf, '00000'.
	self 
		assert: (self ropeableCollection copyFrom: 199995 to: 200005)
		equals: expected.

]

{ #category : #tests }
BlRopeableCollectionFileTest >> testEmptyFileSize [

	| ropeSize |
	ropeSize := (BlRopedText file: self emptyFile) size.
	self assert: ropeSize equals: 0.
]

{ #category : #tests }
BlRopeableCollectionFileTest >> testMapEntryForLarge [

	| collection |

	collection := BlRopeableCollectionFile new.
	10 to: 1000 by: 10 do: [ :i |
		collection map add: i -> (i-1) ].

	self
		assert: (collection mapEntryFor: 5)
		equals: 1 -> 0.

	15 to: 1005 by: 10 do: [ :i |
		self
			assert: (collection mapEntryFor: i)
			equals: (i-5) -> (i-6) ].

	10 to: 1000 by: 10 do: [ :i |
		self
			assert: (collection mapEntryFor: i)
			equals: i -> (i-1) ].

	self
		assert: (collection mapEntryFor: 1010)
		equals: 1000 -> 999.


]

{ #category : #tests }
BlRopeableCollectionFileTest >> testMapEntryForSmall [

	| collection |

	collection := BlRopeableCollectionFile new.
	collection map 
		add: 10 -> 9.

	self
		assert: (collection mapEntryFor: 1)
		equals: 1 -> 0.
	self
		assert: (collection mapEntryFor: 5)
		equals: 1 -> 0.
	self
		assert: (collection mapEntryFor: 10)
		equals: 10 -> 9.
	self
		assert: (collection mapEntryFor: 12)
		equals: 10 -> 9.

]
