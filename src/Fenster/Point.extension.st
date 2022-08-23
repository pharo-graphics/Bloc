Extension { #name : #Point }

{ #category : #'*Fenster' }
Point >> asLogicalPosition [
	^ FensterLogicalPosition fromPoint: self
]

{ #category : #'*Fenster' }
Point >> asLogicalSize [
	^ FensterLogicalSize fromPoint: self
]

{ #category : #'*Fenster' }
Point >> asPhysicalPosition [
	^ FensterPhysicalPosition fromPoint: self
]

{ #category : #'*Fenster' }
Point >> asPhysicalSize [
	^ FensterPhysicalSize fromPoint: self
]
