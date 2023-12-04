Class {
	#name : 'BlInfiniteDataSourceEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'dataSource'
	],
	#category : 'Bloc-Infinite-Events',
	#package : 'Bloc-Infinite',
	#tag : 'Events'
}

{ #category : 'accessing' }
BlInfiniteDataSourceEvent >> dataSource [
	^ dataSource
]

{ #category : 'accessing' }
BlInfiniteDataSourceEvent >> dataSource: anObject [
	dataSource := anObject
]
