localDir = $(shell pwd)

.PHONY: run-server unpopular-opinions warehouse-rfc linux-cpu-scheduling

linux-cpu-scheduling:
	docker run -it -p 80:8080 -v $(localDir)/linux-cpu-scheduling:/app/slides msoedov/hacker-slides

unpopular-opinions:
	docker run -it -p 80:8080 -v $(localDir)/unpopular-opinions:/app/slides msoedov/hacker-slides

warehouse-rfc:
	docker run -it -p 80:8080 -v $(localDir)/warehouse-rfc:/app/slides msoedov/hacker-slides

run-server:
	docker run -it -p 80:8080 -v $(localDir):/app/slides msoedov/hacker-slides