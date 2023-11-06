Class {
	#name : 'BlBlurEvent',
	#superclass : 'BlBaseFocusEvent',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'testing' }
BlBlurEvent >> isBlur [
	^ true
]

{ #category : 'sending' }
BlBlurEvent >> sendTo: anObject [
	anObject blurEvent: self
]
