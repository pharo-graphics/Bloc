"
I represent a font size attribute.
I am used together with BrText and BrTextStyler to style text.

Public API and Key Messages

- size: set font size in points

Example:

	BrFontSizeAttribute size: 20
 
Internal Representation and Key Implementation Points.

    Instance Variables
	size		<Number> 
"
Class {
	#name : #BrFontSizeAttribute,
	#superclass : #BrTextAttribute,
	#instVars : [
		'size'
	],
	#category : 'Bloc-Text-Text-Attributes'
}

{ #category : #'instance creation' }
BrFontSizeAttribute class >> size: aNumber [
	^ self new
		size: aNumber;
		yourself
]

{ #category : #comparing }
BrFontSizeAttribute >> equals: aTextAttribute [
	^ self size = aTextAttribute size
]

{ #category : #comparing }
BrFontSizeAttribute >> hash [
	^ self class hash bitXor: self size hash
]

{ #category : #printing }
BrFontSizeAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'font-size: ';
		nextPutAll: self size asString
]

{ #category : #accessing }
BrFontSizeAttribute >> size [
	^ size
]

{ #category : #accessing }
BrFontSizeAttribute >> size: aNumber [
	size := aNumber
]
