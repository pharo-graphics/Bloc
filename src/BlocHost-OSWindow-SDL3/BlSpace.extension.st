Extension { #name : #BlSpace }

{ #category : #'*BlocHost-OSWindow-SDL3' }
BlSpace >> useSDL3Host [

	self deprecated: 'Use #useSDLHost instead'.
	self useSDLHost
]
