Class {
	#name : #BlFakeDemo,
	#superclass : #Object,
	#category : #'Bloc-Demo-NodeTests'
}

{ #category : #return }
BlFakeDemo >> returnBlElement [

	<demoTestingPragma>
	^ BlElement new background: Color blue
]

{ #category : #return }
BlFakeDemo >> returnBlElement2 [

	<demoTestingPragma>
	^ BlElement new background: Color red
]

{ #category : #return }
BlFakeDemo >> returnBlElementWithADifferentPragma [

	<demoTestingPragma2>
	^ BlElement new background: Color blue
]
