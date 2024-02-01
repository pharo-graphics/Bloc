"
I am one button inside of a Halos element. For more information about me, see {{gtClass:BlDevHalosEventListener}}.

"
Class {
	#name : #BlElementSelectionButton,
	#superclass : #BlElement,
	#category : #'Bloc-DevTool-Core'
}

{ #category : #'instance creation' }
BlElementSelectionButton class >> icon: anSvgIcon [

	^ self new
		geometry: anSvgIcon;
		yourself
]

{ #category : #'instance creation' }
BlElementSelectionButton class >> icon: anSvgIcon extent: aPoint [

	^ self new
		geometry: anSvgIcon;
		size: aPoint;
		yourself
]

{ #category : #initialization }
BlElementSelectionButton >> defaultBackground [
	^ Color black
]
