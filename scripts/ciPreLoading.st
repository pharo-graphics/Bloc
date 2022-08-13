| repoPath |

"
Report main graphic library versions
"

Stdio stdout
	<< 'Cairo: ';
	<< CairoLibrary uniqueInstance versionString; lf.
Stdio stdout
	<< 'Freetype: ';
	print: FT2Library current libraryVersion; lf.
Stdio stdout
	<< 'SDL: '.
SDL2 version printAsSemanticVersioningOn: Stdio stdout.
Stdio stdout lf.

"
Register Iceberg repo
"

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
