Class {
	#name : #Spec2TestPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'nameText',
		'passwordText',
		'acceptButton',
		'cancelButton'
	],
	#category : #'BookletGraphicsBloc-Spec'
}

{ #category : #layout }
Spec2TestPresenter class >> defaultLayout [
	^ SpGridLayout new
				borderWidth: 0;
				add: 'Name:' at: 1 @ 1;
				add: #nameText at: 2 @ 1;
				add: 'Password:' at: 1 @ 2;
				add: #passwordText at: 2 @ 2;
				add:
					(SpBoxLayout newVertical
						add: #acceptButton;
						add: #cancelButton; yourself)
					at: 1 @ 3
					"span: 2 @ 1;
					add: #acceptButton at: 1@3;
					add: #cancelButton at: 2@3;"
				yourself
]

{ #category : #examples }
Spec2TestPresenter class >> open [
<example>
self new openWithSpec
]

{ #category : #accessing }
Spec2TestPresenter >> acceptButton [
	^ acceptButton
]

{ #category : #accessing }
Spec2TestPresenter >> acceptButton: anObject [
	acceptButton := anObject
]

{ #category : #accessing }
Spec2TestPresenter >> cancelButton [
	^ cancelButton
]

{ #category : #accessing }
Spec2TestPresenter >> cancelButton: anObject [
	cancelButton := anObject
]

{ #category : #initialization }
Spec2TestPresenter >> initializePresenters [
<script: 'self new open'>
	nameText := self newTextInput.
	passwordText := self newTextInput
		text: 'Password';
		bePassword.
	acceptButton := self newButton label: 'OK'.
	cancelButton := self newButton label: 'Cancel'.
	self focusOrder
		add: nameText;
		add: passwordText
]

{ #category : #initialization }
Spec2TestPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'first test with spec2'
		";initialExtent: 300@400"
]

{ #category : #accessing }
Spec2TestPresenter >> nameText [
	^ nameText
]

{ #category : #accessing }
Spec2TestPresenter >> nameText: anObject [
	nameText := anObject
]

{ #category : #accessing }
Spec2TestPresenter >> passwordText [
	^ passwordText
]

{ #category : #accessing }
Spec2TestPresenter >> passwordText: anObject [
	passwordText := anObject
]
