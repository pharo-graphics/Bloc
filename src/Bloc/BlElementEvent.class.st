"
I am a root class of all element events that are sent by ==BlElement== as a reaction to various changes, for example position or extent.

See ==BlElementEventExamples== for related examples.
"
Class {
	#name : #BlElementEvent,
	#superclass : #BlEvent,
	#category : 'Bloc-Event'
}

{ #category : #'as yet unclassified' }
BlElementEvent class >> target: aNode [
	^ self new
		target: aNode;
		yourself
]
