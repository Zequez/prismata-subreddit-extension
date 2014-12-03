# Content scripts are sandboxed, so we aren't really
# cluttering the user global scope. The window
# object is different.
@PS = {}