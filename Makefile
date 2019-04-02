XCODE_USER_TEMPLATES_DIR=~/Library/Developer/Xcode/Templates/File\ Templates
PROJECT_NAME=TemplateProject

.PHONY: default
default: run

.PHONY: run
run: templates sourcery carthage

.PHONY: carthage
carthage:
	brew install carthage
	carthage update --platform iOS

.PHONY: sourcery
sourcery:
	brew install sourcery

.PHONY: templates
install_templates:
	rm -R -f $(XCODE_USER_TEMPLATES_DIR)/$(PROJECT_NAME)Templates
	mkdir -p $(XCODE_USER_TEMPLATES_DIR)
	cp -R -f ./.templates $(XCODE_USER_TEMPLATES_DIR)/$(PROJECT_NAME)Templates
