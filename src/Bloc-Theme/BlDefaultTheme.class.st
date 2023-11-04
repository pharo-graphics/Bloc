Class {
	#name : 'BlDefaultTheme',
	#superclass : 'BlTheme',
	#instVars : [
		'link',
		'status',
		'editor',
		'button',
		'item',
		'header',
		'divider',
		'notebook'
	],
	#category : 'Bloc-Theme',
	#package : 'Bloc-Theme'
}

{ #category : 'accessing' }
BlDefaultTheme >> button [
	^ button
]

{ #category : 'accessing' }
BlDefaultTheme >> button: anObject [
	button := anObject
]

{ #category : 'accessing' }
BlDefaultTheme >> divider [

	^ divider
]

{ #category : 'accessing' }
BlDefaultTheme >> divider: aDividerTheme [

	divider := aDividerTheme
]

{ #category : 'accessing' }
BlDefaultTheme >> editor [
	^ editor
]

{ #category : 'accessing' }
BlDefaultTheme >> editor: anObject [
	editor := anObject
]

{ #category : 'accessing' }
BlDefaultTheme >> header [
	^ header
]

{ #category : 'accessing' }
BlDefaultTheme >> header: anObject [
	header := anObject
]

{ #category : 'initialization' }
BlDefaultTheme >> initialize [
	super initialize.
	link := BlDefaultLinkTheme new.
	status := BlDefaultStatusTheme new.
	editor := BlDefaultEditorTheme new.
	button := BlDefaultButtonTheme new.
	item := BlDefaultItemTheme new.
	header := BlDefaultHeaderTheme new.
	divider := BlDefaultDividerTheme new.
	notebook := BlDefaultNotebookTheme new.
]

{ #category : 'accessing' }
BlDefaultTheme >> item [
	^ item
]

{ #category : 'accessing' }
BlDefaultTheme >> item: anObject [
	item := anObject
]

{ #category : 'accessing' }
BlDefaultTheme >> link [
	^ link
]

{ #category : 'accessing' }
BlDefaultTheme >> link: anObject [
	link := anObject
]

{ #category : 'accessing' }
BlDefaultTheme >> notebook [

	^ notebook
]

{ #category : 'accessing' }
BlDefaultTheme >> notebook: anObject [

	notebook := anObject
]

{ #category : 'accessing' }
BlDefaultTheme >> status [
	^ status
]

{ #category : 'accessing' }
BlDefaultTheme >> status: anObject [
	status := anObject
]
