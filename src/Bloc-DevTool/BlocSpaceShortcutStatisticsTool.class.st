"
I am a tool to open a statistics window from a BlSpace.
"
Class {
	#name : #BlocSpaceShortcutStatisticsTool,
	#superclass : #BlocSpaceShortcutTool,
	#category : #'Bloc-DevTool-Space-tools'
}

{ #category : #configuration }
BlocSpaceShortcutStatisticsTool class >> defaultIndex [

	^ 2
]

{ #category : #configuration }
BlocSpaceShortcutStatisticsTool class >> groupName [

	^ 'bloc-space-statistics'
]

{ #category : #configuration }
BlocSpaceShortcutStatisticsTool class >> settingDescription [

	^ 'Shortcut settings to open a window that display different statistics.'
]

{ #category : #configuration }
BlocSpaceShortcutStatisticsTool class >> settingLabel [

	^ 'statistics window'
]

{ #category : #configuration }
BlocSpaceShortcutStatisticsTool class >> shortcutActionOn: aBlSpace [

	aBlSpace showStatisticsWindow
]

{ #category : #'see class side' }
BlocSpaceShortcutStatisticsTool >> seeClassSide [

	
]
