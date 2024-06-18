Class {
	#name : #BlBoundsUpdaterHasChangesDuringLayoutEvent,
	#superclass : #BlEvent,
	#category : #'Bloc-Infinite-Events'
}

{ #category : #sending }
BlBoundsUpdaterHasChangesDuringLayoutEvent >> sendTo: anObject [

	anObject boundsUpdaterHasChangesDuringLayoutEvent: self
]
