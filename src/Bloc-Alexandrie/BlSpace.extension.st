Extension { #name : #BlSpace }

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> useAlexandrieMorphicWindowHost [
	
	self host: BAMorphicWindowHost new
]

{ #category : #'*Bloc-Alexandrie' }
BlSpace >> useAlexandrieOSWindowSDL2Host [
	
	self host: BAOSWindowSDL2Host new
]
