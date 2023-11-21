Extension { #name : 'BlCompositeEffect' }

{ #category : '*Bloc-Alexandrie' }
BlCompositeEffect >> aeDrawAbove: aBlElement on: anAeCanvas [ 
	"Draw the effect on top of the element"
	
	effects do: [ :effect | effect aeDrawAbove: aBlElement on: anAeCanvas ]
]

{ #category : '*Bloc-Alexandrie' }
BlCompositeEffect >> aeDrawBelow: aBlElement on: anAeCanvas [ 
	"Draw on the canvas the effect behind the element"
	
	effects do: [ :effect | effect aeDrawBelow: aBlElement on: anAeCanvas ]
]
