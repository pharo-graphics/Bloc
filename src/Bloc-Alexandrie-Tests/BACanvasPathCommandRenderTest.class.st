Class {
	#name : #BACanvasPathCommandRenderTest,
	#superclass : #AePixelMatchTest,
	#category : #'Bloc-Alexandrie-Tests-Base'
}

{ #category : #hooks }
BACanvasPathCommandRenderTest class >> allFormSelectors [

	^ self selectors select: [ :each | each isUnary and: [each beginsWith: 'render'] ]
]

{ #category : #hooks }
BACanvasPathCommandRenderTest >> expectedFormsDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'bloc' ].
	^ repo location / 'tests' / 'commands'
]
