Class {
	#name : #BlScrollSlideHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'targetElement',
		'sensitivity'
	],
	#category : #'Bloc-PullAndSlide-Handlers'
}

{ #category : #'api - accessing' }
BlScrollSlideHandler >> eventsToHandle [
	^ { BlMouseWheelEvent }
]

{ #category : #initialization }
BlScrollSlideHandler >> initialize [
	super initialize.
	
	sensitivity := 0.8
]

{ #category : #'mouse handlers' }
BlScrollSlideHandler >> mouseWheelEvent: anEvent [

	| aTargetElement |
	anEvent consume.
	
	aTargetElement := targetElement ifNil: [ anEvent currentTarget ].

	aTargetElement children accountedByLayout do: [ :aChild |
		| aHorizontalScrollDelta aVerticalScrollDelta |
		
		aHorizontalScrollDelta := anEvent vector x negated.
		aVerticalScrollDelta := anEvent vector y.
		
		aChild relocate: aChild constraints position + ((aHorizontalScrollDelta @ aVerticalScrollDelta) * self sensitivity) ]
]

{ #category : #accessing }
BlScrollSlideHandler >> sensitivity [
	^ sensitivity
]

{ #category : #accessing }
BlScrollSlideHandler >> sensitivity: anObject [
	sensitivity := anObject
]

{ #category : #accessing }
BlScrollSlideHandler >> targetElement [
	^ targetElement
]

{ #category : #accessing }
BlScrollSlideHandler >> targetElement: anObject [
	targetElement := anObject
]
