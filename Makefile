localDir = $(shell pwd)

.PHONY: run-server unpopular-opinions

unpopular-opinions:
	docker run -it -p 8080:8080 -v $(localDir)/unpopular-opinions:/app/slides msoedov/hacker-slides

run-server:
	docker run -it -p 8080:8080 -v $(localDir):/app/slides msoedov/hacker-slides