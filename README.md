# My Resume

## Overview

This is the source code for my resume.  It is written in Latex and built using a `Makefile` at the command line.

If you are looking for a Word document of my resume, you won't find it here.  In fact, such a document does not exist, anywhere.  I create pdf's using this source code.  I do not have a Word document version.

The project builds three different versions of my resume.

1. The regular version which is a pdf to be shared with prospective employers.

1. The public version, a pdf suitable for posting online which does not contain my phone number and obfuscates many keywords that I don't want to show up in search results.  For example, I don't ever want to show up in the search results when a recruiter is searching for J.a.v.a.S.c.r.i.p.t even though I do have some very small amount of experience with it.  Clever, huh?  J.a.v.a.S.c.r.i.p.t is still readable by humans, but it won't show up in searches.

1. The third version, a zip file containing images, is what I call the "Recruiter Preview" version.  It is the same as the public version but watermarked with the text "I AM NOT REPRESENTED BY THE RECRUITER WHO SHARED THIS WITH YOU", and contains no copyable text.  It consists of a zip file containing an image file of each page.  Recruiters want to see my resume.  I don't want them sharing my resume with prospective employers without my knowledge and consent and not until I have seen and approved the job description for a role.  With the watermark on it, I doubt they will share it with many clients, and the text cannot be copied into another document or scanned into their applicant tracking system.  With this version, they can look at my resume, but that's about all they can easily do with it short of transcribing it manually into a Word document.  If they've shown me a job I want to pursue, I give them the regular version.  Before that, they only get the "Recruiter Preview" version.

> **Q: Do some recruiters get mad because they cannot "use" my resume as they planned, i.e. without my consent?**
>
>> **A:** Yes, they do.  :stuck_out_tongue_winking_eye:
>
> **Q: Do I care that it makes them mad?**
>
>> **A:** No, I do not.  :stuck_out_tongue_winking_eye:  In fact, I rather enjoy it.  It is **my** resume.  I'm in control.  They are not.

## Background

Long ago, I created my first resume, as most do, using Microsoft Word.  Word is fine for many things, but every time I made a change to my resume, there were always tedious corrections to be made to the formatting.  This was very tiresome.

I wanted a better way to handle my resume and more control over the formatting.  I also wanted to use the tools from software development, i.e. version control including diffs, branching, merging, etc. on my resume.  I wanted it written in plaintext with the formatting specified as code.  HTML was an option, but I don't really like HTML or CSS given my experience with them in school.

The other option I thought of was Latex.  Latex is something I had a bit of experience with in school and it creates beautiful documents.  So, I decided to go with Latex.

I also wanted it to be extremely easy to make changes and produce a new version of the documents, preferably from the command line.  So, I decided to use a `Makefile` to do everything at once.

Many hours went into creating this project and refining it over the years.  Mostly because I am not very experienced with Latex.  However, I could not be happier with the results.  It is a joy to make updates to my resume and then build new documents with a command.  Most of the time I have spent on this project was in the initial creation and in the major additions, i.e. adding the public and the recruiter preview versions, for example.  Updates like listing a new job are trivial and take very little time at all.



## Requirements

This project was originally created on a FreeBSD based system.  It uses the version of `make` native to BSD.

Additional packages needed:

```bash
pkg install --yes inotify-tools
pkg install --yes texlive-full
pkg install --yes latex-resume
pkg install --yes pdflatex
pkg install --yes xpdf
pkg install --yes zip
```

On Mac or Linux systems, that version of `make` is called `bmake` and likely will need to be installed.

```bash
brew install bmake
...
```

## Building the Documents

On a BSD system:

```bash
make clean && make
```

On a Mac or Linux system:

```bash
bmake clean && bmake
```

### Rebuild with every file change

On a BSD system:

```bash
make clean && make watch
```

On a Mac or Linux system:

```bash
bmake clean && bmake watch
```

