Extension { #name : #MemoryLogger }

{ #category : #'*Bloc' }
MemoryLogger >> asDictionary [

	^Dictionary new
		at: #name put: name;
		at: #recordings put: recordings;
		yourself.
]

{ #category : #'*Bloc' }
MemoryLogger >> basicRecordings: aCollection [
	"Set the receiver's recordings.
	This is normally only used when loading saved instances from file"

	recordings := aCollection
]

{ #category : #'*Bloc' }
MemoryLogger class >> fromSton: stonReader [

	| logger |

	logger := self basicNew.
	stonReader parseListDo: [ :each :idx |
		idx = 1 ifFalse: [ self error: 'Invalid STON' ].
		logger
			name: (each at: #name);
			basicRecordings: (each at: #recordings) ].
	^logger
]

{ #category : #'*Bloc' }
MemoryLogger class >> fromStonFile: aFileReference [

	| logger |

	logger := aFileReference asFileReference binaryReadStreamDo: [ :bstream |
		STON fromStream: (ZnCharacterReadStream 
			on: (GZipReadStream on: bstream)
			encoding: 'utf8') ].
	^logger
]

{ #category : #'*Bloc' }
MemoryLogger >> saveStonFile: aFileReference [
	"Save the receiver to the supplied file name"

	| stream |

	stream := (ZnCharacterWriteStream 
		on: (GZipWriteStream on: aFileReference asFileReference nextVersion binaryWriteStream)
		encoding: 'utf8').
	[ STON put: self onStreamPretty: stream ]
		ensure: [ stream close ].

]

{ #category : #'*Bloc' }
MemoryLogger >> stonOn: stonWriter [

	stonWriter writeObject: self streamShortList: [ :array |
		array add: self asDictionary ]
]
