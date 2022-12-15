Extension { #name : #BlBorder }

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyTo: aeCanvas element: aBlElement [

	self isTransparent
		ifTrue: [
			self
				aeApplyWithoutBorderTo: aeCanvas
				element: aBlElement ]
		ifFalse: [ 
			aBlElement outskirts
				aeApplyTo: aeCanvas
				element: aBlElement
				border: self.
			aeCanvas setBorderBlock: [ 
				self paint aeApplyTo: aeCanvas.
				self style aeApplyTo: aeCanvas.
				aeCanvas setBorderWidth: self width ] ]
]

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyWithCenteredBorderTo: aeCanvas element: aBlElement [
	
	aeCanvas setOutskirtsCentered.
	aBlElement geometry
		aeApplyTo: aeCanvas
		element: aBlElement
]

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyWithInsideBorderTo: aeCanvas element: aBlElement [

	aeCanvas setOutskirtsInside.
	aBlElement geometry
		aeApplyWithInsideBorderTo: aeCanvas
		element: aBlElement
		borderWidth: self width
]

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyWithOutsideBorderTo: aeCanvas element: aBlElement [

	aeCanvas setOutskirtsOutside.
	aBlElement geometry
		aeApplyWithOutsideBorderTo: aeCanvas
		element: aBlElement
		borderWidth: self width
]

{ #category : #'*Bloc-Alexandrie' }
BlBorder >> aeApplyWithoutBorderTo: aeCanvas element: aBlElement [

	aeCanvas setBorderOff.
	aBlElement geometry
		aeApplyTo: aeCanvas
		element: aBlElement
]
