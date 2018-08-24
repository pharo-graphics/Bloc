"
I am a Nautilus plugin that marks overriden methods in a class that are also defined in a trait with blue icon based on green icon
"
Class {
	#name : #MethodFromTraitOverrideAction,
	#superclass : #AbstractMethodIconAction,
	#category : 'Bloc-DevTool-Nautilus'
}

{ #category : #order }
MethodFromTraitOverrideAction >> actionOrder [
	"Return the priority of this action"
	
	^ 200
]

{ #category : #order }
MethodFromTraitOverrideAction >> isActionHandled [	
	^ self traits isNotEmpty
]

{ #category : #order }
MethodFromTraitOverrideAction >> privateActionIcon [
	"Return the icon for this action"
	| anIcon |
	
	anIcon := (self iconNamed: #traitIcon) collectColors: [ :each | 
		(each mixed: 0.6 with: Color blue) lighter lighter lighter lighter alpha: each alpha ].

	^ IconicButton new 
			target: self traits first;
			actionSelector: #browse;
			labelGraphic: anIcon;
			color: Color transparent;
			extent: self iconExtent;
			helpText: 'Browse the overriden trait';
			borderWidth: 0
]

{ #category : #accessing }
MethodFromTraitOverrideAction >> traits [
	^ (method origin withAllSuperclasses
		collect: [ :aClass | ((aClass traitComposition methodDescriptionsForSelector: method selector) collect: #locatedMethods) ]) flattened
]
