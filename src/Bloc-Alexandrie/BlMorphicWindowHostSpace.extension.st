Extension { #name : #BlMorphicWindowHostSpace }

{ #category : #'*Bloc-Alexandrie' }
BlMorphicWindowHostSpace >> newBlHostRendererSurface [

	^ BlHostRendererFormSurface newForHostSpace: self
]

{ #category : #'*Bloc-Alexandrie' }
BlMorphicWindowHostSpace >> renderer: aRenderer [
	
	renderer := aRenderer
]
