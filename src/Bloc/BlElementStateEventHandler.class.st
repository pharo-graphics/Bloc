Class {
	#name : 'BlElementStateEventHandler',
	#superclass : 'BlCustomEventHandler',
	#classInstVars : [
		'uniqueInstance'
	],
	#package : 'Bloc',
	#tag : 'Basic-State'
}

{ #category : 'accessing' }
BlElementStateEventHandler class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
