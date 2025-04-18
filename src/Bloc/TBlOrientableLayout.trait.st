"
I'm for layout strategies that own an orientation (horizontal or vertical)
I bring simple testing and orientation changing features
"
Trait {
	#name : #TBlOrientableLayout,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #'t - orientable layout' }
TBlOrientableLayout >> beHorizontal: aBoolean [

	self isHorizontal = aBoolean ifTrue: [ ^ self ].
	aBoolean
		ifTrue: [ self beHorizontal ]
		ifFalse: [ self beVertical ]
]

{ #category : #'t - orientable layout' }
TBlOrientableLayout >> beVertical: aBoolean [

	self beHorizontal: aBoolean not
]

{ #category : #'t - orientable layout' }
TBlOrientableLayout >> isHorizontal [

	^ self orientation isHorizontal 
]

{ #category : #'t - orientable layout' }
TBlOrientableLayout >> isOrientable [

	^ true
]

{ #category : #'t - orientable layout' }
TBlOrientableLayout >> isVertical [

	^ self isHorizontal not
]
