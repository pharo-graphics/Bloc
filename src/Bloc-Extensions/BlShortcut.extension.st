Extension { #name : #BlShortcut }

{ #category : #'*Bloc-Extensions' }
BlShortcut >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 10>
	self action notNil ifTrue: [ 
		self action gtInspectorSourceCodeIn: composite ]
]
