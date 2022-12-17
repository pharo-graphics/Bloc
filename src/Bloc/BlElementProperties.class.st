"
# Element properties
That can be propagated from the parent element to the children.
For example font size is by default inherited by the children

"
Class {
	#name : #BlElementProperties,
	#superclass : #Object,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #enumerating }
BlElementProperties >> do: aBlock [
	self properties do: aBlock
]

{ #category : #testing }
BlElementProperties >> isEmpty [
	^ self properties isEmpty
]

{ #category : #testing }
BlElementProperties >> isNotEmpty [
	^ self properties isNotEmpty
]

{ #category : #printing }
BlElementProperties >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' properties: ';
		print: self properties
]

{ #category : #accessing }
BlElementProperties >> properties [
	^ #()
]

{ #category : #accessing }
BlElementProperties >> size [
	^ self properties size
]
