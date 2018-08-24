Extension { #name : #BlClipOutInsetsEffect }

{ #category : #'*Bloc-Sparta' }
BlClipOutInsetsEffect >> clipOutPathFor: anElement [	
	^ self insets inset: anElement bounds inLocal asRectangle
]
