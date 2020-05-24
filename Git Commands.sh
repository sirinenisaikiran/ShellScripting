#*** Please tell me who you are.
#Run

  git config --global user.email "saikiran.sirneni@gmail.com"
  git config --global user.name "sirinenisaikiran"

# Clone command
git clone <repo>



# 1. On your computer, move the file you'd like to upload to GitHub into the local directory that was created when you cloned the repository.
# 2. Open Git Bash.
# 3. Change the current working directory to your local repository.
# 4. Stage the file for commit to your local repository.
	$ git add .
	# Adds the file to your local repository and stages it for commit. To unstage a file, use 'git reset HEAD YOUR-FILE'.

# 5. Commit the file that you've staged in your local repository.
	$ git commit -m "Add existing file"
	# Commits the tracked changes and prepares them to be pushed to a remote repository. To remove this commit and modify the file, use 'git reset --soft HEAD~1' and commit and add the file again.

# 6. Push the changes in your local repository to GitHub.
	$ git push origin your-branch
	# Pushes the changes in your local repository up to the remote repository you specified as th


