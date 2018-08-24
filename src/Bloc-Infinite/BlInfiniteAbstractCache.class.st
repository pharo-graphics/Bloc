Class {
	#name : #BlInfiniteAbstractCache,
	#superclass : #Object,
	#category : 'Bloc-Infinite-Recycler'
}

{ #category : #cache }
BlInfiniteAbstractCache >> elementFor: aRecycler at: aPosition type: anItemType [
	^ self subclassResponsibility
]
