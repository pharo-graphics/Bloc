Extension { #name : #OBlSpace }

{ #category : #'*Bloc-Alexandrie' }
OBlSpace >> aeAsForm [

	^ self layerHolder aeAsForm
]

{ #category : #'*Bloc-Alexandrie' }
OBlSpace >> aeDrawOn: aeCanvas [

	self layerHolder aeDrawOn: aeCanvas

]

{ #category : #'*Bloc-Alexandrie' }
OBlSpace >> useAlexandrieMorphicWindowHost [
	
	self host: BAMorphicWindowHost new
]

{ #category : #'*Bloc-Alexandrie' }
OBlSpace >> useAlexandrieOSWindowSDL2Host [
	
	self host: BAOSWindowSDL2Host new
]
