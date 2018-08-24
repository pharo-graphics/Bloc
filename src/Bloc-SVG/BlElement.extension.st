Extension { #name : #BlElement }

{ #category : #'*Bloc-SVG' }
BlElement >> printString [
	^self userData at:#svgName ifAbsent:[super printString].
]

{ #category : #'*Bloc-SVG' }
BlElement >> skewBy: aPoint [
	self invalidate.
	self transformation skewBy: aPoint.
	self boundsCache invalidateBoundsInSpace.
	self changed
]

{ #category : #'*Bloc-SVG' }
BlElement >> skewX: aX Y: aY [
	self invalidate.
	self transformation skewX: aX Y: aY.
	self boundsCache invalidateBoundsInSpace.
	self changed
]

{ #category : #'*Bloc-SVG' }
BlElement >> svgName:aString [
	^self userData at:#svgName put:aString
]

{ #category : #'*Bloc-SVG' }
BlElement >> transformWithMatrix2D: aBlMatrix2D [
	self invalidate.
	self transformation multiplyByMatrix2D: aBlMatrix2D.
	self boundsCache invalidateBoundsInSpace.
	self changed
]
