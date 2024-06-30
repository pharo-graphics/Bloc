"
I represent an element elevation given in the same units as width and height.
Elevation allows us to achieve very advanced rendering effects that is not possible with z-index.

Taking elevation into account forces us to have a separate composition rendering tree which is different from an element's structure tree.

Note: Elevation is not influenced by transformation matrix!

"
Class {
	#name : #BlElevation,
	#superclass : #Object,
	#instVars : [
		'elevation'
	],
	#classInstVars : [
		'zero'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #cleanup }
BlElevation class >> cleanUp [

	super cleanUp.
	
	zero := nil
]

{ #category : #'instance creation' }
BlElevation class >> elevation: aNumber [

	^ self basicNew
		  initializeWith: aNumber;
		  yourself
]

{ #category : #testing }
BlElevation class >> isAbstract [

	^ self == BlElevation
]

{ #category : #'instance creation' }
BlElevation class >> zero [

	^ zero ifNil: [ zero := self elevation: 0 ]
]

{ #category : #comparing }
BlElevation >> <  another [

	^ self elevation < another elevation
]

{ #category : #comparing }
BlElevation >> >  another [

	^ self elevation > another elevation
]

{ #category : #accessing }
BlElevation >> elevation [

	^ elevation
]

{ #category : #accessing }
BlElevation >> initializeWith: aNumber [

	self initialize.
	elevation := aNumber
]

{ #category : #printing }
BlElevation >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: elevation;
		nextPut: $)

]

{ #category : #accessing }
BlElevation >> relatedTo: aNumber [
	"Return a Number that represents the elevation related to the received value."
	
	^ self subclassResponsibility
]
