Class {
	#name : #BlAbstractImageBackground,
	#superclass : #BlBackground,
	#category : #'Bloc-Basic-Background'
}

{ #category : #testing }
BlAbstractImageBackground class >> isAbstract [

	^ self = BlAbstractImageBackground
]

{ #category : #accessing }
BlAbstractImageBackground >> height [

	self subclassResponsibility
]

{ #category : #testing }
BlAbstractImageBackground >> isTransparent [
	"Unfortunately there is no fast way to detect if a Form is completely transparent,
	the only check we can afford to do is to see whether the extent of the form is positive"

	^ (self opacity closeTo: 0.0) or: [ self width = 0 or: [ self height = 0 ] ]
]

{ #category : #geometry }
BlAbstractImageBackground >> matchExtent: anExtent [
	"Not sure what we should do with image background.
	Will implement later"
]

{ #category : #accessing }
BlAbstractImageBackground >> width [

	self subclassResponsibility
]
