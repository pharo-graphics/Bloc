Extension { #name : #BlMorphicWindowHostSpace }

{ #category : #'*Bloc-Alexandrie' }
BlMorphicWindowHostSpace >> newBlHostRendererSurface [

	^ BlHostRendererFormSurface newForHostSpace: self
]
