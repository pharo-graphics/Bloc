mouse handlers
canScrollDown: anInfiniteElement
	"Return true if an infinite element can be scrolled down"
	<return: #Boolean>	
	| aLastChild |
	
	aLastChild := anInfiniteElement layout childAtPosition: anInfiniteElement layout itemCount.
	aLastChild
		ifNil: [ ^ true ].

	aLastChild position y > (anInfiniteElement layout height - anInfiniteElement layout paddingBottom) 
		ifTrue: [ ^ true ].

	^ false.