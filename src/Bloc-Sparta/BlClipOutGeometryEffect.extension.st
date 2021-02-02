Extension { #name : #BlClipOutGeometryEffect }

{ #category : #'*Bloc-Sparta' }
BlClipOutGeometryEffect >> clipOutPathFor: anElement [
	^ geometry pathOnSpartaCanvas: Bloc preferableSpartaCanvas offscreen of: anElement
]
