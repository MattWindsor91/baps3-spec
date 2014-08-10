GIT		?= git
RUSTBOOK	?= rustbook

all: book

book:
	${RUSTBOOK} build

gh-pages: book
	${GIT} checkout gh-pages
	cp -r _book/* .
	git clean -i
	git commit -am "Update GitHub Pages copy of spec."
	${GIT} checkout master	
