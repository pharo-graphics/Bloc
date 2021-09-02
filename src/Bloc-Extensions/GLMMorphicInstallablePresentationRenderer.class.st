Class {
	#name : 'GLMMorphicInstallablePresentationRenderer',
	#superclass : 'GLMMorphicWidgetRenderer',
	#category : 'Bloc-Extensions-Renderers'
}

{ #category : 'rendering' }
GLMMorphicInstallablePresentationRenderer >> morphFrom: anInstallablePresentation [
	^ self subclassResponsibility
]

{ #category : 'rendering' }
GLMMorphicInstallablePresentationRenderer >> render: anInstallablePresentation [
	^ anInstallablePresentation isAvailable
		ifTrue: [ self morphFrom: anInstallablePresentation ]
		ifFalse: [ self unavailableFrom: anInstallablePresentation ]
]

{ #category : 'rendering' }
GLMMorphicInstallablePresentationRenderer >> unavailableFrom: aPresentation [
	^ Morph new
]
