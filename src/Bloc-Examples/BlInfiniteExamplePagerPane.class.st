Class {
	#name : #BlInfiniteExamplePagerPane,
	#superclass : #Object,
	#instVars : [
		'title',
		'elementBlock'
	],
	#category : #'Bloc-Examples-Infinite'
}

{ #category : #accessing }
BlInfiniteExamplePagerPane >> elementBlock: aBlockClosure [
	elementBlock := aBlockClosure
]

{ #category : #initialization }
BlInfiniteExamplePagerPane >> initialize [
	super initialize.
	
	elementBlock := [ BlElement new size: 100@100; background: Color red ]
]

{ #category : #'instance creation' }
BlInfiniteExamplePagerPane >> paneElement [
	^ elementBlock cull: self
]

{ #category : #accessing }
BlInfiniteExamplePagerPane >> title [
	<return: #String>

	^ title
]

{ #category : #accessing }
BlInfiniteExamplePagerPane >> title: aString [
	title := aString
]
