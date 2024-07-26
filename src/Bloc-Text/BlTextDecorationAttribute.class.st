Class {
	#name : #BlTextDecorationAttribute,
	#superclass : #BlTextAttribute,
	#instVars : [
		'decoration'
	],
	#category : #'Bloc-Text-Text-Attributes'
}

{ #category : #accessing }
BlTextDecorationAttribute >> color [
	^ decoration color
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> color: aColor [
	decoration color: aColor
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> dashed [
	decoration dashed
]

{ #category : #accessing }
BlTextDecorationAttribute >> decoration [
	<return: #BlTextDecoration>

	^ decoration
]

{ #category : #accessing }
BlTextDecorationAttribute >> decoration: aBlTextDecoration [
	decoration := aBlTextDecoration
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> dotted [
	decoration dotted
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> double [
	decoration double
]

{ #category : #comparing }
BlTextDecorationAttribute >> equals: anAnotherAttribute [
	^ self decoration = anAnotherAttribute decoration
]

{ #category : #comparing }
BlTextDecorationAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: decoration hash
]

{ #category : #initialization }
BlTextDecorationAttribute >> initialize [
	super initialize.
	
	decoration := BlTextDecoration new
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> lineThrough [
	decoration withLineThrough
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> overline [
	decoration withOverline
]

{ #category : #printing }
BlTextDecorationAttribute >> printOn: aStream [

	aStream
		nextPutAll: 'decoration: ';
		print: self decoration
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> solid [
	decoration solid
]

{ #category : #accessing }
BlTextDecorationAttribute >> thickness [
	^ decoration thickness
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> thickness: aNumber [
	decoration thickness: aNumber
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> underline [
	decoration withUnderline
]

{ #category : #'api - decoration' }
BlTextDecorationAttribute >> wavy [
	decoration wavy
]
