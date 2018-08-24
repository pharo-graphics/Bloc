"
I represent a text background attribute.
I am used together with BrText and BrTextStyler to style text.

Public API and Key Messages

- paint: set background paint

Example:

	BrTextBackgroundAttribute paint: Color yellow
 
Internal Representation and Key Implementation Points.

    Instance Variables
	paint:		<Object> can be a Color, Pattern, Gradient. Basically anything that is knows how to convert itself to canvas specific paint
"
Class {
	#name : #BrTextBackgroundAttribute,
	#superclass : #BrTextAttribute,
	#instVars : [
		'paint'
	],
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BrTextBackgroundAttribute class >> paint: aPaint [
	^ self new
		paint: aPaint;
		yourself
]

{ #category : #comparing }
BrTextBackgroundAttribute >> equals: aTextAttribute [
	^ self paint = aTextAttribute paint
]

{ #category : #comparing }
BrTextBackgroundAttribute >> hash [
	^ self class hash bitXor: self paint hash
]

{ #category : #accessing }
BrTextBackgroundAttribute >> paint [
	^ paint
]

{ #category : #accessing }
BrTextBackgroundAttribute >> paint: aPaint [
	self
		assert: [ paint isNil ]
		description: [ 'I am immutable and can not be modified' ].

	paint := aPaint
]

{ #category : #printing }
BrTextBackgroundAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'text-background: ';
		nextPutAll: self paint printString
]
