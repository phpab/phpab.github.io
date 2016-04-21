#!/usr/bin/env bash

# Output some debug information:
echo -e "Publishing: $TRAVIS_REPO_SLUG / $TRAVIS_PULL_REQUEST / $TRAVIS_BRANCH / $TRAVIS_BUILD_DIR"

# Setup git defaults:
git config --global user.email "Walter Tamboer"
git config --global user.name "walter@tamboer.nl"

# Setup SSH agent:
eval "$(ssh-agent -s)"
chmod 600 .travis/phpab.github.io
ssh-add .travis/phpab.github.io

if [ -d build ]; then
    rm -rf build/
fi

# Clone the repository in a new directory and move the generated content to it.
git clone --branch master git@github.com:phpab/phpab.github.io.git build

# Delete all the content and copy over the new content
rm -rf build/
cp -R output_prod/* build/

# Move into the cloned repository.
cd build/

# Make sure Jeckyl does nothing:
touch .nojekyll

# Add, commit and push the data
git add --all .
if [ $? -ne 0 ]; then echo -e "Failed to add files to commit."; exit 1; fi

git commit -m "Publishing latest content from build $TRAVIS_COMMIT (Build #$TRAVIS_BUILD_NUMBER)"
if [ $? -ne 0 ]; then echo -e "Failed to create commit."; exit 1; fi

git push -fq origin master > /dev/null;
if [ $? -ne 0 ]; then echo -e "Failed to push changes."; exit 1; fi

echo -e "Finished successfully."
