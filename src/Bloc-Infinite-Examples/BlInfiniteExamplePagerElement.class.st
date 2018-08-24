Class {
	#name : #BlInfiniteExamplePagerElement,
	#superclass : #BlInfiniteElement,
	#category : 'Bloc-Infinite-Examples-Core - Pager'
}

{ #category : #initialization }
BlInfiniteExamplePagerElement >> defaultDataSource [
	^ BlInfiniteExamplePagerPanesDataSource new
]

{ #category : #initialization }
BlInfiniteExamplePagerElement >> defaultLayout [
	^ BlInfiniteLinearLayout new beHorizontal
]
