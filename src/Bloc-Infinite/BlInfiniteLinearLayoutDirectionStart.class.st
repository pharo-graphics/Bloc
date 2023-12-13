Class {
	#name : 'BlInfiniteLinearLayoutDirectionStart',
	#superclass : 'BlInfiniteLinearLayoutDirection',
	#category : 'Bloc-Infinite-Layout-Linear-Support',
	#package : 'Bloc-Infinite',
	#tag : 'Layout-Linear-Support'
}

{ #category : 'testing' }
BlInfiniteLinearLayoutDirectionStart >> isEnd [
	^ false
]

{ #category : 'testing' }
BlInfiniteLinearLayoutDirectionStart >> isStart [
	^ true
]

{ #category : 'converting' }
BlInfiniteLinearLayoutDirectionStart >> multiplier [
	<return: #Number>

	^ -1
]
