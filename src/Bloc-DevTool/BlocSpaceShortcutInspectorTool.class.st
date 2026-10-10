"
I am a tool to open an inspector from a BlSpace.
"
Class {
	#name : #BlocSpaceShortcutInspectorTool,
	#superclass : #BlocSpaceShortcutTool,
	#category : #'Bloc-DevTool-Space-tools'
}

{ #category : #configuration }
BlocSpaceShortcutInspectorTool class >> defaultIndex [

	^ 1
]

{ #category : #configuration }
BlocSpaceShortcutInspectorTool class >> groupName [

	^ 'bloc-space-inspect'
]

{ #category : #configuration }
BlocSpaceShortcutInspectorTool class >> settingDescription [

	^ 'Shortcut settings to open an inspector of a BlSpace.'
]

{ #category : #configuration }
BlocSpaceShortcutInspectorTool class >> settingLabel [

	^ 'space inspect'
]

{ #category : #configuration }
BlocSpaceShortcutInspectorTool class >> shortcutActionOn: aBlSpace [

	aBlSpace inspect
]

{ #category : #'see class side' }
BlocSpaceShortcutInspectorTool >> seeClassSide [

	
]
