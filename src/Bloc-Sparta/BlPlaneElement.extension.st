Extension { #name : #BlPlaneElement }

{ #category : #'*Bloc-Sparta' }
BlPlaneElement >> drawChildrenOnSpartaCanvas: aCanvas [
	self children sortedByElevation
		do: [ :anElement | anElement fullDrawOnSpartaCanvas: aCanvas ]
]
