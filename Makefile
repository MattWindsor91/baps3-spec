GIT		?= git
ANTORA		?= antora
SERVE           ?= serve

all: book

book:
	${ANTORA} antora-playbook.toml

serve:
	${SERVE} build/site

gh-pages: book
	${GIT} checkout gh-pages
	git clean -i
	cp -r build/site/* .
	git add .
	git commit -am "Update GitHub Pages copy of spec."
	${GIT} checkout master	
