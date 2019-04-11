Extension { #name : #BlElement }

{ #category : #'*BlocHost-OSWindow' }
BlElement >> openInNativeWindow [
	| aSpace |
	
	self removeFromParent.
	
	aSpace := BlSpace new.
	aSpace host: BlOSWindowHost default.
	aSpace addChild: self.
	aSpace show
]
