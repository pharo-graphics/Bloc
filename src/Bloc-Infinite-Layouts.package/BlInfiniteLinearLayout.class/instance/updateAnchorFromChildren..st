layout - anchor
updateAnchorFromChildren: anAnchorInfo
	"Finds an anchor child from existing children.
	Most of the time, this is the element closest to start or end that has a valid position (e.g. not removed).
	If a child has focus, it is given priority"
	<return: #Boolean>
	| aFocusedElement aReferenceElement |
	
	self hasChildren
		ifFalse: [ ^ false ].
		
	aFocusedElement := self focusedChild.
	(aFocusedElement isNotNil and: [
		anAnchorInfo isElementValidAsAnchor: aFocusedElement state: self state ])
			ifTrue: [
				anAnchorInfo assignFromElementAndKeepVisible: aFocusedElement in: self.
				^ true ].

	lastStackFromEnd ~= stackFromEnd
		ifTrue: [ ^ false ].

	aReferenceElement := (anAnchorInfo layoutFromEnd
		ifTrue: [ self referenceChildClosestToEnd ]
		ifFalse: [ self referenceChildClosestToStart ] ).
	
	aReferenceElement
		ifNotNil: [ 
			self updateAnchor: anAnchorInfo fromReferenceChild: aReferenceElement.
			^ true ].
	
	^ false	