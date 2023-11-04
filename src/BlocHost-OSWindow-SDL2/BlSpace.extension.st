Extension { #name : 'BlSpace' }

{ #category : '*BlocHost-OSWindow-SDL2' }
BlSpace >> useSDL2Host [
	
	self host: BlOSWindowSDL2Host new
]
