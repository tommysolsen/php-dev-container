build:
	sudo podman build -t tommysolsen/php-dev-container --no-cache .
build_local:
	sudo podman build -t localhost/tommysolsen/php-dev-container --no-cache .