| repoPath |

Stdio stdout << 'PreLoad: Add Iceberg repo at $GITHUB_WORKSPACE --> '.
repoPath := Smalltalk os environment
	at: 'GITHUB_WORKSPACE'
	ifAbsent: [
		Stdio stdout nextPutAll: 'env variable not found'; lf.
		^ self.
	].
Stdio stdout print: repoPath; lf.

(IceRepositoryCreator new
  location: repoPath asFileReference;
  createRepository) register.
