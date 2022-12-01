Extension { #name : #BlSpace }

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> aeAsForm [

	^ self root aeAsForm
]

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> aeDrawOn: aeCanvas [

	self root aeDrawOn: aeCanvas
]

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> useAlexandrieMorphicWindowHost [
	
	self host: BAMorphicWindowHost new
]

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> useAlexandrieOSWindowSDL2Host [
	
	self host: BAOSWindowSDL2Host new
]
