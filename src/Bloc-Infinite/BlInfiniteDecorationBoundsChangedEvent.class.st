Class {
	#name : #BlInfiniteDecorationBoundsChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'decoration'
	],
	#category : #'Bloc-Infinite-Events'
}

{ #category : #accessing }
BlInfiniteDecorationBoundsChangedEvent >> decoration [

	^ decoration
]

{ #category : #accessing }
BlInfiniteDecorationBoundsChangedEvent >> decoration: aBlDesoration [

	decoration := aBlDesoration
]

{ #category : #sending }
BlInfiniteDecorationBoundsChangedEvent >> sendTo: anObject [

	anObject infiniteDecorationBoundsChangedEvent: self
]
