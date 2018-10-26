"
I am a utility holding the Bloc entries in the Morphic World menu
"
Class {
	#name : #BlWorld,
	#superclass : #Object,
	#category : 'Bloc-Extensions-Menu'
}

{ #category : #'world menu' }
BlWorld class >> blocExamplesOn: aBuilder [
	<worldMenu>
	(aBuilder item: #blocExamples)
		parent: #Bloc;
		target: World;
		order: 1;
		action: [ self gtExamplesContained inspect ];
		label: 'Bloc examples'
]

{ #category : #'world menu' }
BlWorld class >> gtExamplesContained [
	^ GtExampleGroup withAll:
			((RPackageOrganizer default packages
				select:
					[ :each | (each name beginsWith: 'Bloc') or: [ each name beginsWith: 'Brick' ] ])
				flatCollect: [ :each | each gtExamplesContained ])
]

{ #category : #'world menu' }
BlWorld class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Bloc)
		order: 6.0; 
		withSeparatorAfter
]

{ #category : #'world menu' }
BlWorld class >> resetUniverseOn: aBuilder [
	<worldMenu>
	(aBuilder item: #resetUniverse)
		parent: #Bloc;
		target: World;
		order: 10;
		action: [ BlUniverse reset ];
		label: 'Reset Bloc Universe'
]
