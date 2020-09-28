Class {
	#name : #BlCompositeLayout,
	#superclass : #BlNodeBasedLayout,
	#instVars : [
		'layouts'
	],
	#category : #'Bloc-Layout-Composite'
}

{ #category : #adding }
BlCompositeLayout >> addLayout: aBlLayout [
	layouts add: aBlLayout
]

{ #category : #adding }
BlCompositeLayout >> initialize [
	super initialize.
	
	layouts := OrderedCollection new
]

{ #category : #layout }
BlCompositeLayout >> layout: aParentLayoutNode [
	layouts do: [ :eachLayout | eachLayout layout: aParentLayoutNode ]
]

{ #category : #measure }
BlCompositeLayout >> measure: aParentLayoutNode [
	layouts do: [ :eachLayout | eachLayout measure: aParentLayoutNode ]
]

{ #category : #'hooks - layout' }
BlCompositeLayout >> onCleanUp: anElement [
	"Is sent when the layout caches should be cleaned up.
	This happens for example when an element is removed from the scene"
	
	layouts do: [ :eachLayout | eachLayout onCleanUp: anElement ]
]

{ #category : #'hooks - layout' }
BlCompositeLayout >> onLayoutDone: anElement [
	"Is sent after layout is completely computed.
	All layout changes done within this hook will be performed during the next frame.
	Note: I am sent before the drawing process"
	
	layouts do: [ :eachLayout | eachLayout onLayoutDone: anElement ]
]
