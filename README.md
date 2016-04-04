# atom-gemfile-unlock package

Use `shift-cmd-m` to read your `Gemfile.lock` and open up all the gems in to a single project. This will let you global search all your gems at once to make it easier to look for those pesky deprecation warnings, or drop your `binding.pry` to debug stuff.

Doing this is already possible with the use of `bundle show` and `bundle open`, but who wants to go one by one? You could also just `grep -Ri` through a directory, but you might get search gems not in your project or wrong versions.
