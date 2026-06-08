Class {
	#name : #BlFakeDemo2,
	#superclass : #Object,
	#category : #'Bloc-Demo-NodeTests'
}

{ #category : #return }
BlFakeDemo2 >> returnBlElement [

	<demoTestingPragma>
	^ BlElement new background: Color blue
]

{ #category : #return }
BlFakeDemo2 >> returnBlElement2 [

	<demoTestingPragma>
	^ BlElement new background: Color red
]

{ #category : #return }
BlFakeDemo2 >> returnBlElement3 [

	<demoTestingPragma>
	^ BlElement new background: Color blue
]

{ #category : #return }
BlFakeDemo2 >> returnNil [

	<demoTestingPragma>
	^ nil
]
