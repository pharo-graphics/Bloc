Class {
	#name : #BlInfiniteItemAnimatorRunner,
	#superclass : #BlTask,
	#instVars : [
		'itemAnimator',
		'isPosted'
	],
	#category : 'Bloc-Infinite-Animator'
}

{ #category : #accessing }
BlInfiniteItemAnimatorRunner >> isPosted [
	^ isPosted
]

{ #category : #running }
BlInfiniteItemAnimatorRunner >> postOn: anInfiniteElement [
	"No need to run animations if infinite element is not attached"
	anInfiniteElement isAttached
		ifFalse: [ ^ self ].
	
	"I was already posted during this frame, skip"
	self isPosted
		ifTrue: [ ^ self ].

	anInfiniteElement postOnAnimation: self.
	isPosted := true
]

{ #category : #running }
BlInfiniteItemAnimatorRunner >> run [
	itemAnimator supportsAnimations
		ifTrue: [ itemAnimator runPendingAnimations ].
	isPosted := false
]
