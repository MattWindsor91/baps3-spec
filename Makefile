GIT		?= git
GITBOOK		?= gitbook

all: book

book:
	${GITBOOK} build

gh-pages: book
	${GIT} checkout gh-pages
	git clean -i
	cp -r _book/* .
	git add .
	git commit -am "Update GitHub Pages copy of spec."
	${GIT} checkout master	
