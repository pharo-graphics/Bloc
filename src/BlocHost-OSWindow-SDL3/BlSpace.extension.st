Extension { #name : #BlSpace }

{ #category : #'*BlocHost-OSWindow-SDL3' }
BlSpace >> useSDL3Host [
	
	self host: BlOSSDL3Host new
]
