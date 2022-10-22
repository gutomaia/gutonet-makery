GITHUB_PROJECT?=
check_origin:
	@if [ ! -n "$(shell git remote -v | grep push | grep ${GITHUB_PROJECT} | awk '{print $$1}')" ]; then \
		git remote add $(shell python -c "import random, string;print(''.join(random.choice(string.ascii_lowercase) for i in range(6)))") git@github.com:${GITHUB_PROJECT}.git; \
		fi

deploy_dev: check_origin
	git push $(shell git remote -v | grep push | grep ${GITHUB_PROJECT} | awk '{print $$1}') $(shell git branch --list | grep \* | ${VIRTUALENV} python -c "import sys,re;r=re.match('\* \(HEAD detached at ([\.a-z0-9]+)\)|\* (.*)', sys.stdin.readline()); a = r.group(1) if r.group(1) else r.group(2); print(a)"):dev --force

deploy_test: check_origin
	git push $(shell git remote -v | grep push | grep ${GITHUB_PROJECT} | awk '{print $$1}') $(shell git branch --list | grep \* | ${VIRTUALENV} python -c "import sys,re;r=re.match('\* \(HEAD detached at ([\.a-z0-9]+)\)|\* (.*)', sys.stdin.readline()); a = r.group(1) if r.group(1) else r.group(2); print(a)"):test --force

deploy_prod: check_origin
	git push $(shell git remote -v | grep push | grep ${GITHUB_PROJECT} | awk '{print $$1}') $(shell git branch --list | grep \* | ${VIRTUALENV} python -c "import sys,re;r=re.match('\* \(HEAD detached at ([\.a-z0-9]+)\)|\* (.*)', sys.stdin.readline()); a = r.group(1) if r.group(1) else r.group(2); print(a)"):prod --force
