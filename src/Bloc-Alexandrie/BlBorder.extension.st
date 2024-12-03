Extension { #name : #BlBorder }

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyTo: aeCanvas element: aBlElement [

	"No need to set any parameter as there is no border"
	self isTransparent ifTrue: [ ^ aeCanvas setBorderOff ].

	"This will double-dispatch with the geometry, and 
	may set an explicit border path for the outskirt."
	aBlElement outskirts
		aeApplyTo: aeCanvas
		element: aBlElement
		border: self.

	"Set common parameters to all outskirts.
	The canvas will evaluate this block for drawing
	the border stroke."
	aeCanvas setBorderBlock: [
		paint aeApplyTo: aeCanvas.

		aeCanvas
			setDashes: style dashArray
			offset: style dashOffset.

		aBlElement geometry hasJoins ifTrue: [
			style lineJoin aeApplyTo: aeCanvas style: style ].

		(aBlElement geometry hasCaps or: [ style isDashed ]) ifTrue: [
			style lineCap aeApplyTo: aeCanvas ].

		aeCanvas setBorderWidth: width ]
]

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyWithCenteredBorderTo: aeCanvas element: aBlElement [
	
	aeCanvas setOutskirtsCentered
]

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement [

	aeCanvas setOutskirtsInside.
	aBlElement geometry
		aeApplyWithInsideBorderTo: aeCanvas
		element: aBlElement
		borderWidth: width
]

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement [

	aeCanvas setOutskirtsOutside.
	aBlElement geometry
		aeApplyWithOutsideBorderTo: aeCanvas
		element: aBlElement
		borderWidth: width
]
