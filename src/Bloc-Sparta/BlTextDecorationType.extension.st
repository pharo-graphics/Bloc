Extension { #name : #BlTextDecorationType }

{ #category : #'*Bloc-Sparta' }
BlTextDecorationType >> applyOnSkiaDecoration: aSkiaTextDecoration [
	aSkiaTextDecoration type: self asSkiaDecorationType
]

{ #category : #'*Bloc-Sparta' }
BlTextDecorationType >> asSkiaDecorationType [
	^ self subclassResponsibility
]
