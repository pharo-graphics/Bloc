as yet unclassified
loadBlocInIceberg: anOrderedPackageList
	| repository |
	repository := (Smalltalk classNamed: #IceRepository) origin: 'git@github.com:pharo-graphics/Bloc.git'.
	repository subdirectory: 'src'.
	repository checkoutBranch: 'master'.
	repository register.
	
	NonInteractiveTranscript stdout cr.
	anOrderedPackageList do: [ :package | 
			NonInteractiveTranscript stdout show: 'Loading latest version of ' , package , '...';cr.
			repository updatePackage: package ].
		
	repository pull