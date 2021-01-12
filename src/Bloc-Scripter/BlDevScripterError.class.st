"
I am an ${class:Error}$ providing extra ${class:BlDevScripter}$ information.
"
Class {
	#name : #BlDevScripterError,
	#superclass : #Error,
	#traits : 'TBlDevScripterException',
	#classTraits : 'TBlDevScripterException classTrait',
	#instVars : [
		'scripter',
		'exception'
	],
	#category : #'Bloc-Scripter-Scripter-Exceptions'
}
