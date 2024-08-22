Class {
	#name : #PasswordDialogPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'nameText',
		'passwordText',
		'acceptButton',
		'cancelButton'
	],
	#category : #'BookletGraphicsBloc-Spec'
}

{ #category : #accessing }
PasswordDialogPresenter >> acceptButton [
	^ acceptButton
]

{ #category : #accessing }
PasswordDialogPresenter >> acceptButton: anObject [
	acceptButton := anObject
]

{ #category : #accessing }
PasswordDialogPresenter >> cancelButton [
	^ cancelButton
]

{ #category : #accessing }
PasswordDialogPresenter >> cancelButton: anObject [
	cancelButton := anObject
]

{ #category : #initialization }
PasswordDialogPresenter >> initializePresenters [
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
PasswordDialogPresenter >> initializeWindow: aWindowPresenter [
"is it better to use this window, or method self withWindowDo: [ :window |
		window
			title: 'password window example';
			initialExtent: 300 @ 140 ]"
		
	"aWindowPresenter
		title: 'password window example';
		initialExtent: 300 @ 140"
]

{ #category : #accessing }
PasswordDialogPresenter >> layout [

	^ SpBoxLayout newTopToBottom
		  vAlignStart;
		  spacing: 10;
		  add: (SpBoxLayout newLeftToRight
				   vAlignCenter;
				   add: 'Name:';
				   add: nameText;
				   yourself);
		  add: (SpBoxLayout newLeftToRight
				   vAlignCenter;
				   add: 'Password:';
				   add: passwordText;
				   yourself);
		  addLast: (SpBoxLayout newLeftToRight beHomogeneous
				   borderWidth: 10;
				   add: (SpBoxLayout newTopToBottom hAlignCenter
						    add: acceptButton expand: false;
						    yourself);
				   add: (SpBoxLayout newTopToBottom hAlignCenter
						    add: cancelButton expand: false;
						    yourself);
				   yourself)
]

{ #category : #accessing }
PasswordDialogPresenter >> nameText [
	^ nameText
]

{ #category : #accessing }
PasswordDialogPresenter >> nameText: anObject [
	nameText := anObject
]

{ #category : #showing }
PasswordDialogPresenter >> open [

	super open.
	self withWindowDo: [ :window |
		window
			title: 'password window example';
			initialExtent: 300 @ 140 ]
]

{ #category : #accessing }
PasswordDialogPresenter >> passwordText [
	^ passwordText
]

{ #category : #accessing }
PasswordDialogPresenter >> passwordText: anObject [
	passwordText := anObject
]

{ #category : #'instance creation' }
PasswordDialogPresenter >> start [
<script: 'self new open'>
]
