Python 3.7.6 (default, Dec 30 2019, 19:38:28) 
[Clang 11.0.0 (clang-1100.0.33.16)] on darwin
Type "help", "copyright", "credits" or "license()" for more information.
WARNING: The version of Tcl/Tk (8.5.9) in use may be unstable. Visit
http://www.python.org/download/mac/tcltk/ for current information.
>>> def count_word(fn,):
    counts = {}  
    import os.path
    if os.path.isfile(fn):
        with open(fn, 'r') as fh:
            contents = fh.read()
            #contents = contents.replace(':'," ")
            #contents = contents.replace('.'," ")
            #contents = contents.replace('/'," ")
            words = contents.split()
            print(len(words))
            
count_word('/Users/bxw/Desktop/项目实践4/SES2020spring/unit2/readme.md')

