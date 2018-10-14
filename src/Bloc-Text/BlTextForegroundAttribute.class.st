"
I represent a text foreground attribute.
I am used together with BrText and BtTextStyler to style text.

Public API and Key Messages

- paint: set foreground paint

Example:

	BrTextForegroundAttribute paint: Color blue
 
Internal Representation and Key Implementation Points.

    Instance Variables
	paint:		<Object> can be a Color, Pattern, Gradient. Basically anything that is knows how to convert itself to canvas specific paint
"
Class {
	#name : #BlTextForegroundAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'paint'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BlTextForegroundAttribute class >> paint: aPaint [
	^ self new
		paint: aPaint;
		yourself
]

{ #category : #comparing }
BlTextForegroundAttribute >> equals: aTextAttribute [
	^ self paint = aTextAttribute paint
]

{ #category : #comparing }
BlTextForegroundAttribute >> hash [
	^ self class hash bitXor: self paint hash
]

{ #category : #accessing }
BlTextForegroundAttribute >> paint [
	^ paint
]

{ #category : #accessing }
BlTextForegroundAttribute >> paint: aPaint [
	self
		assert: [ paint isNil ]
		description: [ 'I am immutable and can not be modified' ].

	paint := aPaint
]

{ #category : #printing }
BlTextForegroundAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'text-foreground: ';
		nextPutAll: self paint printString
]
