"
I represent a text background attribute.
I am used together with `BlText` and `BlTextStyler` to style text.

Public API and Key Messages

- paint: set background paint

Example:

	BlTextBackgroundAttribute paint: Color yellow
 
Internal Representation and Key Implementation Points.

    Instance Variables
	paint:		<Object> can be a Color, Pattern, Gradient. Basically anything that is knows how to convert itself to canvas specific paint

"
Class {
	#name : #BlTextBackgroundAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'paint'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlTextBackgroundAttribute class >> paint: aPaint [
	^ self new
		paint: aPaint;
		yourself
]

{ #category : #comparing }
BlTextBackgroundAttribute >> equals: anAnotherAttribute [
	^ self paint = anAnotherAttribute paint
]

{ #category : #comparing }
BlTextBackgroundAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self paint hash
]

{ #category : #accessing }
BlTextBackgroundAttribute >> paint [
	^ paint
]

{ #category : #accessing }
BlTextBackgroundAttribute >> paint: aPaint [
	self
		assert: [ paint isNil ]
		description: [ 'I am immutable and can not be modified' ].

	paint := aPaint
]

{ #category : #printing }
BlTextBackgroundAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'text-background: ';
		nextPutAll: self paint printString
]
