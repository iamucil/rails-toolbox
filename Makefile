TOOLBOX_IMAGE ?= ruby-toolbox

.PHONY: project

project:
	@echo "building toolbox image..."
	@docker build -t $(TOOLBOX_IMAGE) -f ./Dockerfile \
		--build-arg USER_ID=$(shell id -u) \
		--build-arg GROUP_ID=$(shell id -u) \
		. > /dev/null
	@echo "$(TOOLBOX_IMAGE) successfully builded"
	@read -p "Enter project name: " PROJECT; \
	echo "generate project " $${PROJECT}; \
	docker run --rm -i -t \
	--workdir /opt/app \
	-v $(CURDIR):/opt/app \
	$(TOOLBOX_IMAGE) \
	rails new --skip-bundle /opt/app/.cache/$${PROJECT:-blog}; \
	echo "your project is ready"; \
	cd ./.cache/$${PROJECT:-blog}

