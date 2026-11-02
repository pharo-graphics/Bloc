Extension { #name : #BlSpace }

{ #category : #'*BlocHost-OSWindow-SDL2' }
BlSpace >> useSDL2Host [

	self deprecated: 'Use #useSDLHost instead'.
	self useSDLHost
]
