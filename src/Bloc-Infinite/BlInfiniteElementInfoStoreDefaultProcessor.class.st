"
I process  appearing/disappearing element records
"
Class {
	#name : #BlInfiniteElementInfoStoreDefaultProcessor,
	#superclass : #BlInfiniteElementInfoStoreProcessor,
	#instVars : [
		'infiniteElement'
	],
	#category : 'Bloc-Infinite-Basic'
}

{ #category : #'instance creation' }
BlInfiniteElementInfoStoreDefaultProcessor class >> on: anInfiniteElement [
	^ self new
		initializeWith: anInfiniteElement;
		yourself
]

{ #category : #initialization }
BlInfiniteElementInfoStoreDefaultProcessor >> initializeWith: anInfiniteElement [
	infiniteElement := anInfiniteElement
]

{ #category : #processing }
BlInfiniteElementInfoStoreDefaultProcessor >> processPersistent: anElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder [

	anElementHolder isRecyclable: false.
	(infiniteElement isDataSourceChangedAfterLayout)
		ifTrue: [ 
			"since it was rebound, use change instead as we'll be mapping them from stable ids.
			If stable ids were false, we would not be running any animations"
			(infiniteElement itemAnimator
				animateChange: anElementHolder
				previousHolder: anElementHolder
				preLayoutInfo: aPreInfoHolder
				postLayoutInfo: aPostInfoHolder)
					ifTrue: [ infiniteElement postAnimationRunner ] ]
		ifFalse: [ 
			(infiniteElement itemAnimator
				animatePersistence: anElementHolder
				preLayoutInfo: aPreInfoHolder
				postLayoutInfo: aPostInfoHolder)
					ifTrue: [ infiniteElement postAnimationRunner ] ]
]
