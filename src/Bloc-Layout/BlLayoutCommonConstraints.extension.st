Extension { #name : #BlLayoutCommonConstraints }

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> flow [
	^ self at: BlFlowLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> frame [
	^ self at: BlFrameLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> grid [
	^ self at: BlGridLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> linear [
	^ self at: BlLinearLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> proportional [

	^ self at: BlProportionalLayout
]

{ #category : #'*Bloc-Layout' }
BlLayoutCommonConstraints >> relative [
	^ self at: BlRelativeLayout
]
