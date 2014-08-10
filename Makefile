GIT		?= git
RUSTBOOK	?= rustbook

all: book

book:
	${RUSTBOOK} build

gh-pages: book
	${GIT} checkout gh-pages
	cp -r _book/* .
	${GIT} checkout master	
