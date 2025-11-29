Class {
	#name : #BlDemoData,
	#superclass : #Object,
	#category : #'Bloc-Demo-NodeTests'
}

{ #category : #'return ' }
BlDemoData >> returnBlElement [

	<demo>
	^ BlElement new background: Color blue
]

{ #category : #'return ' }
BlDemoData >> returnBlElement2 [

	<demo>
	^ BlElement new background: Color red
]

{ #category : #'return ' }
BlDemoData >> returnBlElementWithADifferentPragma [

	<demo2>
	^ BlElement new background: Color blue
]
