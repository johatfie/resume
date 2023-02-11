# This is file 'vc-git.awk' from the vc bundle for TeX.
# The original file can be found at CTAN:support/vc.
# This file is Public Domain.

BEGIN {
	modified = 0
}

### Process output of "git log"
script == "log" && /^Hash:/            { Hash            = substr($0, 2+match($0, ":")) }
script == "log" && /^AbrHash:/         { AbrHash         = substr($0, 2+match($0, ":")) }
script == "log" && /^ParentHashes:/    { ParentHashes    = substr($0, 2+match($0, ":")) }
script == "log" && /^AbrParentHashes:/ { AbrParentHashes = substr($0, 2+match($0, ":")) }
script == "log" && /^AuthorName:/      { AuthorName      = substr($0, 2+match($0, ":")) }
script == "log" && /^AuthorEmail:/     { AuthorEmail     = substr($0, 2+match($0, ":")) }
script == "log" && /^AuthorDate:/      { AuthorDate      = substr($0, 2+match($0, ":")) }
script == "log" && /^CommitterName:/   { CommitterName   = substr($0, 2+match($0, ":")) }
script == "log" && /^CommitterEmail:/  { CommitterEmail  = substr($0, 2+match($0, ":")) }
script == "log" && /^CommitterDate:/   { CommitterDate   = substr($0, 2+match($0, ":")) }

### Process output of "git status"
### Changed index?
script == "status" && /^[mMADRCU] /         { modified = 1 }
### Unstaged modifications?
script == "status" && /^ [mMADRCU]/         { modified = 1 }
### Unresolved merge conflicts?
script == "status" && /^[mMADRCU][mMADRCU]/ { modified = 1 }

END {
	### Process output of "git log"
	if (script == "log") {
		### Format dates
		LongDate = substr(CommitterDate, 1, 25)
		DateRAW = substr(LongDate, 1, 10)
		DateISO = DateRAW
		DateTEX = DateISO
		gsub("-", "/", DateTEX)
		Time = substr(LongDate, 12, 14)

		print "%%% This file has been generated by the vc bundle for TeX."
		print "%%% Do not edit this file!"
		print "%%%"

		print "%%% Define Git specific macros."
		print "\\gdef\\GITHash{" Hash "}%"
		print "\\gdef\\GITAbrHash{" AbrHash "}%"
		print "\\gdef\\GITParentHashes{" ParentHashes "}%"
		print "\\gdef\\GITAbrParentHashes{" AbrParentHashes "}%"
		print "\\gdef\\GITAuthorName{" AuthorName "}%"
		print "\\gdef\\GITAuthorEmail{" AuthorEmail "}%"
		print "\\gdef\\GITAuthorDate{" AuthorDate "}%"
		print "\\gdef\\GITCommitterName{" CommitterName "}%"
		print "\\gdef\\GITCommitterEmail{" CommitterEmail "}%"
		print "\\gdef\\GITCommitterDate{" CommitterDate "}%"

		print "%%% Define generic version control macros."
		print "\\gdef\\VCRevision{\\GITAbrHash}%"
		print "\\gdef\\VCAuthor{\\GITAuthorName}%"
		print "\\gdef\\VCDateRAW{" DateRAW "}%"
		print "\\gdef\\VCDateISO{" DateISO "}%"
		print "\\gdef\\VCDateTEX{" DateTEX "}%"
		print "\\gdef\\VCTime{" Time "}%"
		print "\\gdef\\VCModifiedText{\\textcolor{red}{with local modifications!}}%"

		print "%%% Assume clean working copy."
		print "\\gdef\\VCModified{0}%"
		print "\\gdef\\VCRevisionMod{\\VCRevision}%"
	}

	### Process output of "git status"
	if (script=="status") {
		print "%%% Is working copy modified?"
		print "\\gdef\\VCModified{" modified "}%"
		if (modified == 0) {
			print "\\gdef\\VCRevisionMod{\\VCRevision}%"
		} else {
			print "\\gdef\\VCRevisionMod{\\VCRevision~\\VCModifiedText}%"
		}
	}

}
