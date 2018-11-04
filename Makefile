XCODE_USER_TEMPLATES_DIR=~/Library/Developer/Xcode/Templates/File\ Templates
PROJECT_NAME=TemplateProject

.PHONY: default
default: run

.PHONY: run
run: install_brew install_bundle carthage

.PHONY: carthage
carthage: install_brew
	carthage bootstrap --platform iOS --cache-builds --no-use-binaries

.PHONY: install_brew
isntall_brew:
	brew install sourcery carthage swiftlint

.PHONY: install_bundle
isntall_bundle:
	bundle install

.PHONY: templates
install_templates:
	rm -R -f $(XCODE_USER_TEMPLATES_DIR)/$(PROJECT_NAME)Templates
	mkdir -p $(XCODE_USER_TEMPLATES_DIR)
	cp -R -f ./.templates $(XCODE_USER_TEMPLATES_DIR)/$(PROJECT_NAME)Templates

.PHONY: remove_templates
remove_templates:
	rm -R -f $(XCODE_USER_TEMPLATES_DIR)/$(PROJECT_NAME)Templates
