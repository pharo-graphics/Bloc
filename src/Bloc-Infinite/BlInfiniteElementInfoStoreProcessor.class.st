"
I define an api of info store records processor
"
Class {
	#name : #BlInfiniteElementInfoStoreProcessor,
	#superclass : #Object,
	#category : 'Bloc-Infinite-Basic'
}

{ #category : #processing }
BlInfiniteElementInfoStoreProcessor >> processAppeared: anElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder [
	self subclassResponsibility
]

{ #category : #processing }
BlInfiniteElementInfoStoreProcessor >> processDisappeared: anElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder [
	self subclassResponsibility
]

{ #category : #processing }
BlInfiniteElementInfoStoreProcessor >> processPersistent: anElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder [
	self subclassResponsibility
]

{ #category : #processing }
BlInfiniteElementInfoStoreProcessor >> unused: anElementHolder [
	self subclassResponsibility
]
