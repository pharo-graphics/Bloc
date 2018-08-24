Class {
	#name : #BlBlurEvent,
	#superclass : #BlBaseFocusEvent,
	#category : 'Bloc-Event'
}

{ #category : #testing }
BlBlurEvent >> isBlur [
	^ true
]

{ #category : #sending }
BlBlurEvent >> sendTo: anObject [
	anObject blurEvent: self
]
