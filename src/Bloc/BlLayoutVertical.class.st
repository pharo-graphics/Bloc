"
I am a concrete vertical orientation

"
Class {
	#name : 'BlLayoutVertical',
	#superclass : 'BlLayoutOrientation',
	#package : 'Bloc',
	#tag : 'Layouts-Support'
}

{ #category : 'testing' }
BlLayoutVertical >> isHorizontal [
	^ false
]

{ #category : 'testing' }
BlLayoutVertical >> isVertical [
	^ true
]

{ #category : 'dispatch' }
BlLayoutVertical >> of: anObject [
	^ anObject vertical
]
