if [ "$TRAVIS_PULL_REQUEST" = "false" ] && [ "$TRAVIS_SECURE_ENV_VARS" = "true" ]; then
    # we need to clone the repo once again, as by default Travis CI makes
    # shallow clones where gh-pages branch is not available and can't be fetched
    git clone "https://github.com/${TRAVIS_REPO_SLUG}.git" hashspace-gh-pages && cd hashspace-gh-pages &&
    git config user.email "releasebot@ariatemplates.com" &&
    git config user.name "Titan Bot" &&
    git checkout -b gh-pages origin/gh-pages &&
    cp -rv ../dist . &&
    # web site publication is disabled for now:
    # grunt release &&
    # we add everything
    git add -f . &&
    # we let git check for deleted files (grunt release is auto removing all
    # files related to docs)
    git add -u &&
    git commit -m "release ${TRAVIS_COMMIT}" &&
    git push --quiet "https://${GH_CREDENTIALS}@github.com/${TRAVIS_REPO_SLUG}.git" gh-pages
fi
