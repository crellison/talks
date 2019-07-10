localDir = $(shell pwd)

.PHONY: run-server unpopular-opinions warehouse-rfc

unpopular-opinions:
	docker run -it -p 80:8080 -v $(localDir)/unpopular-opinions:/app/slides msoedov/hacker-slides

warehouse-rfc:
	docker run -it -p 80:8080 -v $(localDir)/warehouse-rfc:/app/slides msoedov/hacker-slides

run-server:
	docker run -it -p 80:8080 -v $(localDir):/app/slides msoedov/hacker-slides