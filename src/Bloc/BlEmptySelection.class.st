"
I am an empty selection

"
Class {
	#name : 'BlEmptySelection',
	#superclass : 'BlSelection',
	#category : 'Bloc-Utilities - Selection',
	#package : 'Bloc',
	#tag : 'Utilities - Selection'
}

{ #category : 'accessing' }
BlEmptySelection >> children [
	<return: #Collection of: #BlSelection>
	
	^ #()
]

{ #category : 'api - testing' }
BlEmptySelection >> contains: anIndex [
	"Return true if this selection interval includes a given index, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : 'api - testing' }
BlEmptySelection >> containsIndex: anIndex [
	"Return true if selection indices include a given index, false otherwise.
	I am conceptually same as (self indices includes: anIndex)"
	<return: #Boolean>
	
	^ false
]

{ #category : 'copying' }
BlEmptySelection >> copyFrom: aStartIndex to: anEndIndex [
	^ self copy
]

{ #category : 'api - enumerating' }
BlEmptySelection >> do: aBlock [
	"Evaluate a given block with all recorded selection intervals"
]

{ #category : 'api - testing' }
BlEmptySelection >> isEmpty [
	^ true
]

{ #category : 'api - testing' }
BlEmptySelection >> isNotEmpty [
	^ self isEmpty not
]

{ #category : 'api - enumerating' }
BlEmptySelection >> reverseDo: aBlock [
	"Evaluate a given block with all recorded selection intervals in reverse direction"
]
