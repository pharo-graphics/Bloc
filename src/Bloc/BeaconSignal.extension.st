Extension { #name : #BeaconSignal }

{ #category : #'*Bloc' }
BeaconSignal >> asStonDictionary [

	^Dictionary new
		at: #timestamp put: timestamp;
		at: #processId put: processId;
		at: #properties put: properties;
		yourself.
]

{ #category : #'*Bloc' }
BeaconSignal >> basicProcessId: aString [
	"Set the receiver's processId.
	This is normally only used when loading saved instances from file"

	processId := aString
]

{ #category : #'*Bloc' }
BeaconSignal >> basicProperties: aDictionary [
	"Set the receiver's properties.
	This is normally only used when loading saved instances from file"

	properties := aDictionary
]

{ #category : #'*Bloc' }
BeaconSignal >> basicTimestamp: aTimestamp [
	"Set the receivers timestamp.
	This is normally only used when loading saved instances from file"

	timestamp := aTimestamp
]

{ #category : #'*Bloc' }
BeaconSignal class >> fromSton: stonReader [

	| signal |

	signal := self new.
	stonReader parseListDo: [ :each :idx |
		idx = 1 ifFalse: [ self error: 'Invalid STON' ].
		signal
			basicTimestamp: (each at: #timestamp);
			basicProcessId: (each at: #processId);
			basicProperties: (each at: #properties) ].
	^signal
]

{ #category : #'*Bloc' }
BeaconSignal >> stonOn: stonWriter [

	stonWriter writeObject: self streamShortList: [ :array |
		array add: self asStonDictionary ]
]
