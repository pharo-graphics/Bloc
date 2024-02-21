Extension { #name : #Point }

{ #category : #'*Bloc-Display' }
Point >> asLogicalPosition [
	^ BlLogicalDisplayPosition fromPoint: self
]

{ #category : #'*Bloc-Display' }
Point >> asLogicalSize [

	^ BlLogicalDisplaySize fromPoint: self
]

{ #category : #'*Bloc-Display' }
Point >> asPhysicalPosition [
	^ BlPhysicalDisplayPosition fromPoint: self
]

{ #category : #'*Bloc-Display' }
Point >> asPhysicalSize [
	^ BlPhysicalDisplaySize fromPoint: self
]
