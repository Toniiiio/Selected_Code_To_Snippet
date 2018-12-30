# RStudio snippets

The `package:snippets` enables you to (add/remove/read) [snippets](https://blog.rstudio.com/2015/04/13/rstudio-v0-99-preview-code-snippets/) programmatically.


**Usage:** (assigning a keyboard shortcut is recommended, see: "Combining  with keyboard shortcuts:")

![alt text](snippet.gif "Logo Title Text 1")



Via code:
```
addSnippet("test", "print('This is long code i dont want to retype everytime')")
```

```
readSnippet("test")
snippet test
    print('This is long code i dont want to retype everytime')
```

```
removeSnippet("test")
```

**Installation**

For latest development version:

```devtools::install_github('Timag/snippets')```

**Combining  with keyboard shortcuts:**
![alt text](snippet.png "Logo Title Text 1")

(Usual way so far is to access RStudio snippets via: RStudio - Tools - Global Options - Code - Edit Snippets...)

**Open issues:**

Snippets seem only to be updated if `r.snippets` file will opened afterwards (in RStudio). As a workaround i call
`file.edit("~/.R/snippets/r.snippets")` at the end of the functions.
