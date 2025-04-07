Class {
	#name : #BlLayoutFitContentLimitedOffsetResizer,
	#superclass : #BlLayoutFitContentLimitedResizer,
	#instVars : [
		'offset'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #accessing }
BlLayoutFitContentLimitedOffsetResizer class >> offset: aNumber [
	^ self new
		offset: aNumber;
		yourself
]

{ #category : #'double dispatching' }
BlLayoutFitContentLimitedOffsetResizer >> measurementAtMostWith: aNumber [

	^ super measurementAtMostWith: aNumber - offset
]

{ #category : #'double dispatching' }
BlLayoutFitContentLimitedOffsetResizer >> measurementExactlyWith: aNumber [
	^ super measurementExactlyWith: aNumber - offset
]

{ #category : #accessing }
BlLayoutFitContentLimitedOffsetResizer >> offset [
	^ offset
]

{ #category : #accessing }
BlLayoutFitContentLimitedOffsetResizer >> offset: anObject [
	offset := anObject
]

{ #category : #printing }
BlLayoutFitContentLimitedOffsetResizer >> printOn: aStream [
	aStream nextPutAll: 'Fit content limited offset: '.
	offset printOn: aStream
]
