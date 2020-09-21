Class {
	#name : #BlLayoutNodeChildren,
	#superclass : #Array,
	#type : #variable,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - geometry' }
BlLayoutNodeChildren >> measuredBounds [
	^ self collect: [ :eachChild | eachChild measuredBounds asRectangle ] as: Array
]

{ #category : #'api - geometry' }
BlLayoutNodeChildren >> normalizePositions [
	| theTopLeft |

	self
		ifEmpty: [ ^ self ].

	theTopLeft := self inject: self first measurement position into: [ :topLeft :eachNode | 
		topLeft min: eachNode measurement position ].
	
	self do: [ :eachNode | eachNode measurement position: eachNode measurement position - theTopLeft ]
]

{ #category : #converting }
BlLayoutNodeChildren >> withoutElement [
	^ self collect: [ :eachNode | eachNode withoutElement ]
]
