all: brew base pip3 # Make all files

brew: ## Install homebrew and brewfiles
	sh install/brew.sh || true

base: ## Install base configs
	sh install.sh || true

pip3: ## Ensure pip3 packages in requirements.in are installed
	pip3 install --upgrade pip-tools
	python3 -m piptools compile --output-file requirements3.txt requirements3.in
	pip3 install \
		--requirement requirements3.txt \
		--src ~/oss \
		--exists-action s

