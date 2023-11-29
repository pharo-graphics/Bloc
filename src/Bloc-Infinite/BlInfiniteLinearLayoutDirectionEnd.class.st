Class {
	#name : 'BlInfiniteLinearLayoutDirectionEnd',
	#superclass : 'BlInfiniteLinearLayoutDirection',
	#category : 'Bloc-Infinite-Layout-Linear-Support',
	#package : 'Bloc-Infinite',
	#tag : 'Layout-Linear-Support'
}

{ #category : 'testing' }
BlInfiniteLinearLayoutDirectionEnd >> isEnd [
	^ true
]

{ #category : 'testing' }
BlInfiniteLinearLayoutDirectionEnd >> isStart [
	^ false
]

{ #category : 'converting' }
BlInfiniteLinearLayoutDirectionEnd >> multiplier [
	<return: #Number>

	^ 1
]
