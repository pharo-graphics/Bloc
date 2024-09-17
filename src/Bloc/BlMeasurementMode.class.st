"
I describe a mode of measurement specification. There are three modes which are my subclasses:
 - at most, meaning that element is allowed to be at most of specified size
 - exact, meaning that element should have exact size provided in specification
 - unspecified, meaning that we still can say anything how big an element should be. Maybe its size depends on children or parent, so we need first to find sizes of dependent element and then come back

Generally I represent an internal class which in most cases should not used directly by user or developers of custom layout strategies.

My main methods are
 - measurement: aResizing with: aNumber to determine which measurement spec should be used to measure children based on their resizing property and possible size provided by parent. It uses double dispatch (BlMeasurementMode <-> BlLayoutResizing)
 - sizeFor: aNumber. find out the final value for the size of element based on provided possible size with single dispatching to my subclasses

"
Class {
	#name : #BlMeasurementMode,
	#superclass : #Object,
	#classInstVars : [
		'atMost',
		'exact',
		'unspecified'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #accessing }
BlMeasurementMode class >> atMost [
	<return: #BlMeasurementMode>

	^ atMost ifNil: [ atMost := BlMeasurementAtMostMode new ]
]

{ #category : #cleanup }
BlMeasurementMode class >> cleanUp [
	super cleanUp.
	
	atMost := nil.
	exact := nil.
	unspecified := nil
]

{ #category : #accessing }
BlMeasurementMode class >> exact [
	<return: #BlMeasurementMode>
	
	^ exact ifNil: [ exact := BlMeasurementExactMode new ]
]

{ #category : #accessing }
BlMeasurementMode class >> unspecified [
	<return: #BlMeasurementMode>
	
	^ unspecified ifNil: [ unspecified := BlMeasurementUnspecifiedMode new ]
]

{ #category : #comparing }
BlMeasurementMode >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	^ anotherObject class == self class
]

{ #category : #comparing }
BlMeasurementMode >> hash [
	^ self class hash
]

{ #category : #testing }
BlMeasurementMode >> isAtMost [
	^ false
]

{ #category : #testing }
BlMeasurementMode >> isExact [
	^ false
]

{ #category : #testing }
BlMeasurementMode >> isUnspecified [
	^ false
]

{ #category : #geometry }
BlMeasurementMode >> measurement: aResizing with: aNumber [
	<return: #BlMeasurementSpec>
	
	^ self subclassResponsibility
]

{ #category : #printing }
BlMeasurementMode >> printOn: aStream size: aNumber [
	"Prints measurement mode with taking a given size into account"
	self subclassResponsibility
]

{ #category : #geometry }
BlMeasurementMode >> size: aNumber min: aMinSize max: aMaxSize [
	"Answer a `BlMeasurementSpec`"

	^ self subclassResponsibility
]

{ #category : #geometry }
BlMeasurementMode >> size: aNumber with: aSpecSize [
	"Answer the size that corresponds to this measurement mode."

	^ self subclassResponsibility
]
