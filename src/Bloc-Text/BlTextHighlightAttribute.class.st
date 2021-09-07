Class {
	#name : 'BlTextHighlightAttribute',
	#superclass : 'BlTextAttribute',
	#instVars : [
		'paint'
	],
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : 'accessing' }
BlTextHighlightAttribute class >> paint: aPaint [
	^ self new
		paint: aPaint;
		yourself
]

{ #category : 'comparing' }
BlTextHighlightAttribute >> equals: anAnotherAttribute [
	^ self paint = anAnotherAttribute paint
]

{ #category : 'comparing' }
BlTextHighlightAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self paint hash
]

{ #category : 'accessing' }
BlTextHighlightAttribute >> paint [
	^ paint
]

{ #category : 'accessing' }
BlTextHighlightAttribute >> paint: aPaint [
	self
		assert: [ paint isNil ]
		description: [ 'I am immutable and can not be modified' ].

	paint := aPaint
]

{ #category : 'printing' }
BlTextHighlightAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'text-highlight: ';
		nextPutAll: self paint printString
]
