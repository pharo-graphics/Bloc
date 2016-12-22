loading - git
icebergLoad: thePackages from: aRepositoryUrl
	| aRepository |

	self ensureIceberg.

	aRepository := ((Smalltalk classNamed: #Iceberg) mcRepositoryFor: aRepositoryUrl) repository.
	aRepository checkoutBranch: self gitBranch.
	"No need to register here. It was already done in mcRepositoryFor:"
	
	NonInteractiveTranscript stdout cr.
	thePackages do: [ :aPackage | 
			NonInteractiveTranscript stdout show: 'Loading latest version of ' , aPackage , '...';cr.
			aRepository updatePackage: aPackage ].

	aRepository pull