all: index

index: index.html

index.html: index.Rmd
	Rscript -e '\
	library(rmarkdown);\
	render("$<")'
