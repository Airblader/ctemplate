# ctemplate

This is a simple template for C applications.

## Usage

* Copy the `template/` folder somewhere and rename it to the name of your project.
* Do a `grep -air project .` and replace all occurences of `PROJECT` with the name of your project.
* Rename `src/project.c` accordingly.
* Rename `man/project.man` accordingly and put in your name, email address and a description.
* Change author and year in `LICENSE` or exchange the license for a different one.
* Edit `Makefile`, uncomment the line defining `LIBS` and add the libraries you need (optional).
* Start a git repository (`git init`) and commit all files (`git add -A && git commit -m "Initial commit"`).

Now you should be able to make and install your application via `make && sudo make install`.
