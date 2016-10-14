# tab-lint
A simple bash script to lint your project for tabs.

This works great as part of your test suite because it will print out the offending lines and exit with an error code if any tabs are found in the project files.

## Setup
Change `FILE_TYPES` to a pipe delimited list of file extensions you would like to check. Currently configured for a standard Ruby on Rails project.

## Ignore directories
You may wish to add other directories to ignore. The current directories ignored are:

```
+ ./vendor
+ ./coverage
```

To ignore other directories, simply add them to the `IGNORE_DIRECTORIES` array.

